$.update_homepage_pic = function(data){
	// var html = "<div>"
	console.log("+++++++++++++update_homepage_pic+++++++++++++++")
	var img = new Image();
	// var img =document.createElement("img")
	var src = "/assets/"+data['content_type']+"/"+data['disk_filename']
	img.setAttribute("src",src);
	console.log(img)
	$("#sale").append(img)
}
$.show_alert= function(info,color,hold){
	// var frag = document.createDocumentFragment();
	var message_doc = document.createElement("div")
	// var header = document.createElement("div");
	message_doc.setAttribute("id","show_alert");
	message_doc.style.position="fixed";
	message_doc.style.top="0px";
	message_doc.style.left ="50%";
	message_doc.style.backgroundColor = color ? color : "yellow"
	message_doc.innerText = info ? info : "Nothing to display!"
	// frag.appendChild(message_doc); 
	// document.body.innerHTML += "";
	document.body.appendChild(message_doc)
	if (!hold) {
		setTimeout(function(){
			document.getElementById('show_alert').remove();
		},6000)
	};
}
$.message_notes=function(data){
	console.log(data)
	if (data.message) {
		$("#notes").append(data.message)
	}else{
		$("#notes").append(data)
	}
}