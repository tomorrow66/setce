jQuery(function()
{
	$('li.link').hover(function()
	{
		$(this).css("cursor", "pointer");
	});
	
	$('li.link').click(function()
	{
		url = $(this).attr('data-url');
		window.location = url
	});
	

	
/*
	$(".mainnav").mouseover(function(){
	      	$(this).children('ul').css("display", "block");
	    }).mouseout(function(){
	     		$(this).children('ul').css("display", "none");
	    });
*/
});