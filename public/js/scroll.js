$(function() {

    var $sidebar   = $(".tree span"), 
        $window    = $(window),
        offset     = $sidebar.offset(),
        topPadding = 15; 

    $window.scroll(function() {
        if ($window.scrollTop() > offset.top) {
						$sidebar.addClass('fixed');

        } else {
						$sidebar.removeClass('fixed');
        }
    });
    
});
