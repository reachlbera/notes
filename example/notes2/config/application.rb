require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Notes
  class Application < Rails::Application
  	config.assets.precompile += %w( bs-sass-3.1.1/bootstrap.css bootstrap/bootstrap-3.0.0/bootstrap-datetimepicker.css fontawesome/font-awesome.min.css base/base.css dropzone/dropzone.css */*.css */*.scss *.css *.scss *.js *.coffe */*.js */*.coffe *.mp4 *.wmv)
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
