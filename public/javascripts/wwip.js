$(document).ready(function(){
	$("#badges input").each(function(){
		$(this).focus(function(){ this.select() });
	});
	
	$('#loading').show();
	$.getJSON("http://weworkinphilly.com/people.json?callback=?", function(data){
           $.each(data, function(){
     	 
       	      $("<img/>").attr("src", "http://s3.amazonaws.com/weworkinphilly/photos/"+ this.person.id +"/medium/"+ this.person.photo_file_name)
     	      .attr("title", this.person.name).attr("id","img"+this.person.user_id).appendTo("#images")
              .wrap('<a href="http://weworkinphilly.com/people/'+this.person.slug+'" />');
           });
     }).complete(function() { $('#loading').hide(); });;
	
});
