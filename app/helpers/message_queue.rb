#encoding=utf-8

#rails版

require 'bunny'
require 'thread'

=begin
  在Gemfile里添加gem 'bunny'
  
  require File.expand_path(Rails.root + 'app/helpers/message_queue.rb', __FILE__) #根据情况修改加载路径
  启动监听队列 config/environment.rb
  MessageQueue.startup


  发送消息时:
  MessageQueue::Asynchronous.send_message(message, headers, return_invoke)
  return_invoke是自己定义的方法 但是需要有2个参数(message, headers) return_invoke也可以不填

  broadcast_message和publish_message没有return_invoke参数
=end

module MessageQueue
  extend self

  SETTING = YAML::load(File.read(File.expand_path(Rails.root + 'config/rabbitmq.yml', __FILE__))).deep_symbolize_keys

  # 连接Rabbitmq服务器
  def connection_message_queue
    Bunny.new(SETTING[:connection]).tap(&:start)
  end

  # 创建通道
  def create_message_channel(connection)
    connection.create_channel
  end

  # 创建同步调用的临时队列
  def create_synchronous_temporary_queue(channel, queue_name, synchronous = false)
    return false if queue_name.nil? || queue_name.empty?
    return channel.queue(queue_name, :exclusive => true, :auto_delete => true) if synchronous
    channel.queue(queue_name) # 同步调用不能加:auto_delete => true 或者用exchange
  end

  def create_default_exchange(channel, direct = nil)
    return channel.direct(direct) if direct
    channel.default_exchange     
  end

  def create_fanout_exchange(channel, fanout_name)
    return false if fanout_name.nil? || fanout_name.empty?
    channel.fanout(fanout_name)
  end

  def create_topic_exchange(channel, topic_name)
    return false if topic_name.nil? || topic_name.empty?
    channel.topic(topic_name)
  end

  def handle_headers(headers)
    return false unless headers.is_a?(Hash)
    headers.deep_symbolize_keys
  end

  def handle_message(message)
    msg = message.is_a?(String) ? message : message.to_json
    msg
  end

  #没有消费者的消息会返回到这个方法中
  def return_message(channel, invoke)
    x = channel.default_exchange
    x.on_return do |return_info, properties, body|
      instance_eval(invoke + ' body, properties.headers')
    end
  end

  # 监听自己的订阅队列
  def listen_subscribe_queue(connection, q_name, s_name, invoke)
    return false if q_name.nil? || s_name.nil? || invoke.nil?
    channel = create_message_channel(connection)
    exchange = channel.direct(s_name + '_tenmind')
    channel.basic_qos(1, false)
    queue_name = s_name + q_name.split('.')[1].downcase # 保证同一主队列订阅的同一队列不会重复收到消息   *****
    channel.queue(queue_name).bind(exchange, :routing_key => 'subscribe_' + s_name).subscribe(:manual_ack => true) do |delivery_info, properties, body|
      instance_eval(invoke + ' body, properties.headers')
      channel.basic_ack(delivery_info.delivery_tag, false)
    end
  end

  # 监听自己唯一的消息队列
  def listen_message_queue(connection, name, invoke)
    return false if name.nil? || invoke.nil?
    channel = create_message_channel(connection)
    exchange = channel.topic('tenmind_broadcast')
    channel.basic_qos(1, false)
    routing_key = 'tenmind.all.queue.broadcast.message.#'
    channel.queue(name).bind(exchange, :routing_key => routing_key).subscribe(:manual_ack => true) do |delivery_info, properties, body|
      instance_eval(invoke + ' body, properties.headers')
      channel.basic_ack(delivery_info.delivery_tag, false)
    end
  end

  # 启动所有的监听队列
  def startup
    systems = SETTING[:queue_lists]
    return false if systems.nil? || systems.empty?
    connection = connection_message_queue
    channel = create_message_channel(connection)
    channel.confirm_select  # 确认机制
    success = channel.wait_for_confirms
    systems.each do |queue|
      queue = queue.deep_symbolize_keys
      listen_message_queue(connection, queue[:name], queue[:invoke])
      queue[:subscribe_lists]&&queue[:subscribe_lists].each do |subscribe|
        subscribe = subscribe.deep_symbolize_keys
        listen_subscribe_queue(connection, queue[:name], subscribe[:name], subscribe[:invoke])
      end
    end
  end
  # -------------------------------------------

  # 异步发布
  module Asynchronous
    include MessageQueue
    extend self

    # headers = { 'type' => '', 'sender' => '', 'receiver' => [], 'path' => '', 'method' => '' }
    # 消息持久化 persistent == true
    # 发布消息 -> 必须要有自己的队列名称
    # 添加订阅者断网时为其保存消息的情况
    def publish_message(message, headers, persistent = false)
      headers = handle_headers(headers)
      return false if headers[:sender].nil? || headers[:sender].empty?
      pers = persistent.eql?(true) ? true : false
      connection = connection_message_queue
      channel = create_message_channel(connection)
      channel.confirm_select      #确认机制
      success = channel.wait_for_confirms
      direct = create_default_exchange(channel, headers[:sender] + '_tenmind')
      direct.publish(handle_message(message), :routing_key =>'subscribe_' + headers[:sender], :headers => headers, :persistent => pers, :mandatory => true)
      connection.close
    end

    # 指定接收队列发布 -> 必须要有接收队列的名称
    def send_message(message, headers, return_invoke = '', persistent = false)
      headers = handle_headers(headers)
      return false if headers[:receiver].nil? || headers[:receiver].empty?
      pers = persistent.eql?(true) ? true : false
      connection = connection_message_queue
      channel = create_message_channel(connection)
      exchange = create_default_exchange(channel)
      return_message(channel, return_invoke) if !return_invoke.empty?
      exchange.publish(handle_message(message), :routing_key => headers[:receiver], :headers => headers, :persistent => pers, :mandatory => true)
      connection.close
    end

    # 群发
    def broadcast_message(message, headers, persistent = false)
      pers = persistent.eql?(true) ? true : false
      connection = connection_message_queue
      channel = create_message_channel(connection)
      channel.confirm_select
      success = channel.wait_for_confirms
      topic = create_topic_exchange(channel, 'tenmind_broadcast')
      routing_key = 'tenmind.all.queue.broadcast.message'
      topic.publish(handle_message(message), :routing_key => routing_key, :headers => headers, :persistent => pers, :mandatory => true)
      connection.close
    end

    # 回复同步发布
    # def tenmind_reply_synchronous_queue(message, headers, persistent = false)
    def reply_remote_call(message, headers, return_invoke = '', persistent = false)
      headers = handle_headers(headers)
      return false if headers[:reply_to].nil? || headers[:reply_to].empty?
      pers = persistent.eql?(true) ? true : false
      connection = connection_message_queue
      channel = create_message_channel(connection)
      exchange = create_default_exchange(channel)
      return_message(channel, return_invoke) if !return_invoke.empty?
      exchange.publish(handle_message(message), :routing_key => headers[:reply_to], :headers => headers, :persistent => pers, :mandatory => true)
      connection.close
    end
  end

  # 同步发布
  # class SynchronousPublish
  # 调用
  # synchronous = MessageQueue::Synchronous.new(server_queue, my_queue)
  # result = synchronous.remote_call(message, headers)
  class Synchronous
    include MessageQueue

    attr_reader :lock, :condition
    attr_accessor :response, :call_id, :content

    def initialize(server_queue, my_queue)
      # @server_queue = create_synchronous_temporary_queue(server_queue) # 用exchange也可以实现
      @server_queue = server_queue
      self.call_id = self.generate_uuid
      @connection = connection_message_queue
      @channel = create_message_channel(@connection)         
      @exchange = create_default_exchange(@channel)
      @reply_queue = create_synchronous_temporary_queue(@channel, my_queue + self.call_id, true) 
        @lock = Mutex.new
        @condition = ConditionVariable.new
        that = self
        @reply_queue.subscribe do |delivery_info, properties, payload|
          if properties.headers['correlation_id'] == that.call_id
            that.response = payload
                that.content = properties.headers
                that.lock.synchronize{ that.condition.signal }
            end
        end
    end

    # 设置请求超时时间 30秒
    def remote_call(message, headers, return_invoke = '', persistent = false)
      pers = persistent.eql?(true) ? true : false
      head = headers.merge({:reply_to => @reply_queue.name, :correlation_id => call_id})
      return_message(@channel, return_invoke) if !return_invoke.empty?
      @exchange.publish(handle_message(message), :routing_key => @server_queue, :headers => head, :persistent => pers, :mandatory => true)
      timeout(30){
        lock.synchronize{ condition.wait(lock) }
        @reply_queue.delete  # 解锁后先删除创建的临时队列 再返回值
        @connection.close #关闭连接
        { :message => response, :headers => content }
      } rescue handle_timeout
    end

    # 处理超时情况
    def handle_timeout
      lock.synchronize{ condition.signal }
      @reply_queue.delete # 超时后删除临时队列
      @connection.close  #关闭连接
      'timeout'
    end

    protected

    def generate_uuid
      "#{rand}#{rand}#{rand}"
    end
  end
end