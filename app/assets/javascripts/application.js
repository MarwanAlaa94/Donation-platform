// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

//=require bootstrap


var i = 0;


function duplicate() {
	var images = document.getElementById("images");
	var original = document.getElementById('image');
    var clone = original.cloneNode(true); // "deep" clone
    clone.id = "image" + ++i;
    // or clone.id = ""; if the divs don't need an ID
    images.appendChild(clone);

}
function addImageDiv(c){

    var images = document.getElementById("images");
    var div = document.createElement('div');
	div.id = "image" + ++c;

	div.innerHTML = '<label for="organization_org_images_attributes_'+c+'_caption">New Image Caption: *</label>'
           + '<input required="required" class="form-control" type="text" name="organization[org_images_attributes]['+c+'][caption]" id="organization_org_images_attributes_'+c+'_caption">'
           + '<label for="organization_org_images_attributes_'+c+'_photo">New Image File: *</label>'
           + '<input class="form-control" required="required" type="file" name="organization[org_images_attributes]['+c+'][photo]" id="organization_org_images_attributes_'+c+'_photo">';

	images.appendChild(div);
}

function remove(id, url) {
	var el = document.getElementById( id);
	el.parentNode.removeChild( el );
	$('#hamada').load(url + ' #hamada'); 
}


function removeAndAlert(id, message) {
	var el = document.getElementById( id);
	el.parentNode.removeChild( el );
	alert(message);
}