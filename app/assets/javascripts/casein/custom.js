// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript

// require ckeditor/init

// CKEDITOR.config.menu_groups = "";
// CKEDITOR.config.plugins = "basicstyles,removeformat,menu,contextmenu,resize,toolbar,enterkey,entities,wysiwygarea,link,pastefromword,specialchar,tab";

//console.log(CKEDITOR.config);

//= require_self

$(function() {
var $video = $('#news_video');

	$video.on('blur', function() {

		var videoVal = $video.val(),
			youtubeUrl = videoVal.split('https://youtu.be/')[0],
			youtubeCode = videoVal.split('https://youtu.be/')[1];

		if (youtubeUrl ==  '') {
			$($video).val(youtubeCode);
		}

	})
});
