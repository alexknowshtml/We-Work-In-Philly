$(document).ready(function(){
	$("#badges input").each(function(){
		$(this).focus(function(){ this.select() });
	});
});
