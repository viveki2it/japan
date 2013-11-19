//= require jquery
//= require jquery_ujs
//= require jquery-migrate
//
//= require bootstrap-modal
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require bootstrap-collapse
//= require bootstrap-dropdown
//
//= require underscore
//= require hamlcoffee
//= require backbone
//= require backbone-support
//
//= require_tree ./plugins
//= require non-backbone-js/common/imports
//
//= require jquery.lightbox-0.5.min
//= require jquery.ui.datepicker
//= require jquery.ui.datepicker-fr
//= require jquery.ui.autocomplete
//= require rails_admin/jquery.ui.timepicker
//= require modernizr
//= require iframe-transport


$(document).ready(function () {

	$('#landing-slider').css({'height' : '', 'overflow-y' : ''});

  	// landing slider
  	$('#landing-slider').codaSlider({
    	autoSlide:true,
      autoHeight:false,
      slideEaseFunction: 'linear',
      dynamicTabs: false,
  		slideEaseDuration: 400
  	});

	// Home page: hidden arrow on scroll
	if ($('#scroll-bottom').css('display') == 'block')
	    $(document).bind('scroll', hideArrow);
	function hideArrow() {
	    if ($(document).scrollTop() > 400)
	        $('#scroll-bottom').hide();
	}

	// Masonry
    var $container = $('#masonry, #masonry-products');

    $container.imagesLoaded( function() {
      $container.find('.article').addClass('masonry-item');

      $container.masonry({
        itemSelector : '.masonry-item',
        columnWidth: function( containerWidth ) {
        	return containerWidth / 4;
        },
      });

      $("a.masonry-filter").click(function() {
        $("a.masonry-filter").removeClass("current");
        $(this).addClass("current");
        $container.find('.article').removeClass('masonry-item').hide();
        $container.find('.article' + $(this).data('masonry-filter')).addClass('masonry-item').show();
        $container.masonry('reload');
        return false;
      });

    });

    // show dropdown
    $('.dropdown-toggle').click(function (event) {
        var dropdown = $(this).parent().find('.m-dropdown-menu');
        if (dropdown.css('display') == 'none')
            dropdown.show();
        else
            dropdown.hide();

        // clicks out the dropdown
        $('body').click(function (event) {
            if (!$(event.target).is('.m-dropdown-menu a')) {
                $(this).find('.m-dropdown-menu').hide();
            }
        });
        event.stopPropagation();
    });

    $(".m-loader.page-loader").remove();
    
    /**
     * Show the content of a tooltip when it's set
     */
    $("a[data-content]").popover({
		placement: "top",
		trigger: "hover",
		html: true,
		title: "<strong>" + $(this).attr("title") +"</strong>"
	}); //This is the Twitter bootstrap function
});

// alert
function showAlert(message, time) {
    $('#header').append('<div class="m-alert">' + message + '</div>');
    setTimeout(function() {
        $('.m-alert').hide()
    },5000);
}


// Extend the default String object with a formatMoney() method:
// usage: someVar.formatMoney(decimalPlaces, symbol, thousandsSeparator, decimalSeparator)
// defaults: (2, "€", ",", ",")
String.prototype.formatMoney = function(places, symbol, thousand, decimal) {
	places = !isNaN(places = Math.abs(places)) ? places : 2;
	symbol = symbol !== undefined ? symbol : "€";
	thousand = thousand || ",";
	decimal = decimal || ",";
	var number = Number(this),
	    negative = number < 0 ? "-" : "",
	    i = parseInt(number = Math.abs(+number || 0).toFixed(places), 10) + "",
	    j = (j = i.length) > 3 ? j % 3 : 0;

	// Remove decimals if they equal 00
	var decimal_numbers = (places ? decimal + Math.abs(number - i).toFixed(places).slice(2) : "");

	if (decimal_numbers == ",00"){
		decimal_numbers = "";
	}

	return negative + (j ? i.substr(0, j) + thousand : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousand) + decimal_numbers + " " + symbol;
};


function testMailAddress(address) {
	var email_check = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,6}$/i;
	if(!email_check.test(address)){
		return false;
	}
	return true;
}
