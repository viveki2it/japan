//= require common
//= require user-app/main
//= require non-backbone-js/user-app/imports
//= require components
//= require raphael

/**
 * Global Javascript file
 */

$(document).ready(function () {
    /* USER APP
     * ============================ */

    // Prevent a click on the "create board button" if the user has reached the limit
    $(".new-board a").click(function(event) {
    	var reached_limit = $(this).attr("data-limit-reached");

    	if (reached_limit == "true") {
    		event.preventDefault();
    		event.stopPropagation();
    		$(this).closest("div").css("margin-left", "-193px");
    		$(this).html("Nombre maximum de boards atteint").delay(5000).fadeOut();
    	}
    });

    // 1st connexion - form validation
    $('#categories button.valid').click(function () {

        // step1
        if ($('#categories .u-step1').css('display') == 'block') {
            $('#categories .u-step1').slideToggle();
            $('#categories .u-step2').slideToggle();
            $('#categories').addClass('currentStep2');
            $('#categories .back').show();
        }
        // step2
        else if ($('#categories').hasClass('currentStep2')) {
            $('#categories .u-step2').slideToggle();
            $('#categories .u-step3').slideToggle();
            $('#categories h2').text('Où faites-vous du shopping ?');

            $('#categories').removeClass('currentStep2').addClass('currentStep3');
        }
        // step3
        else {
            $('#categories form').slideToggle();
            $('#categories').animate({'padding-bottom':'0em'}, function () {
                $('#categories').hide();
            });
            $('.subheader-text').animate({'top':'-70px'}, function () {
                $('.subheader-text').hide();
            });
            $('.articles .cache').hide('slow');
            $('#header.is-centered a.logo-jm').animate({ 'margin-left':'0' });
            $('.new-board, .search, .profile-wrap', $('#header')).css('display', 'inline-block');
            $('.subheader-nav').show('slow');
            $('body').removeClass('is-not-configured').addClass('is-configured');
            $('body').scrollTop();
        }

        return false;
    });

    // 1st connexion - go back
    $('#categories button.back').click(function () {
        if ($('#categories').hasClass('currentStep2')) {
            $('#categories .u-step1').slideToggle();
            $('#categories .u-step2').slideToggle();
            $('#categories .back').hide();
            $('#categories').removeClass('currentStep2');
        } else {
            $('#categories h2').text("Qu'est-ce qui vous intéresse ?");
            $('#categories .u-step2').slideToggle();
            $('#categories .u-step3').slideToggle();
            $('#categories').addClass('currentStep2').removeClass('currentStep3');
        }

        return false;
    });

    function showDialog($item) {
        var cache = $('<div class="cache-black"></div>');
        cache.append($('<span class="wrap-icon" id="profile-close"><span class="icon i-cross"></span></span>'));
        cache.append($('<span class="logo-jm"></span>'));
        cache.append($item.clone().show());
        $('body').append(cache);
        cache.animate({ 'opacity':1 }, 300, function(){
        	// fix the content behind the modal
            $('#header, #container, #footer, #signin-section').css('position', 'fixed');
            $('.cache-black').css({'position': 'absolute', 'height': '100%', 'min-height': '100%'});

            // go at top of the page
            $('body').scrollTop(0);
        });

        $('#profile-close').click(function () {
        	// stop fix the content behind the modal
        	$('#header, #container, #footer, #signin-section').css('position', '');
            $('.cache-black').animate({ 'opacity':0 }, 300, function () {
                $(this).remove();
            });
        });
        enablePlaceholdersForIE();
    }

    // open filters
    $('#filters').bind('click', function(){
    	if( $(this).parent().hasClass('subcat') ) {
    		$('#filters-categories .u-step2').slideToggle();
    		$('#filters-categories .u-step1').slideUp();
    	} else {
    		$('#filters-categories .u-step1').slideToggle();
    		$('#filters-categories .u-step2').slideUp();
    	}
    });

    // help slides
    $('#container').on("click", '#btn-help', function(){

    	// init
    	$('body')
    		.addClass('m-help')
    		.prepend('<div class="help-cache"></div>')
    		.prepend('<div class="help-cache-transparent"></div>');
    	$('.help-cache-transparent')
    		.append('<div class="help-step1"></div>')
    		.append("<a class='btn close' id='btn-close' onclick='closeHelp();' href='javascript:void(0)'>Fermer l'aide</a>");
        $('.l-header-fullimg').css({'z-index': '110', 'height': '54px'});
        //$('.l-header-fullimg').height(54);
        $('#header').css('z-index', '1000');      
        $("#filters").animate({'opacity' : '0.5'})
        $('.help-step1').popover({
			title: '1. Votre board',
			content: 'Il diffuse des produits, des promotions, et des actualités de boutiques à Paris en fonction de vos intérêts et des quartiers que vous fréquentez.<br /><a class="btn color1 next-help2" href="javascript:void(0)" onclick="goHelp2()">Suivant</a>',
			animation: true,
			html: true
		})

    	// step 1 - New board
    	$('.m-help .help-cache').show().animate({'opacity': '1'}, function(){           
    		$('.help-step1').popover('show');
    		$(".m-help .popover").animate({'opacity': '1'});
    	});
        $('.l-header-fullimg').css({'z-index': '110', 'height': '54px'});
    	return false;
    });

	// go to step 2 - Search
	$('#new-board .btn').click(function(){
		$('#new-board .popover').animate({'opacity': '0'}, function(){
    		$(this).hide();
			$('#search .popover').show().animate({'opacity': '1'});
		});
		return false;
	});

	// go to step 3 -
	$('#search .btn').click(function(){
		$('#search .popover').animate({'opacity': '0'}, function(){
			$(this).hide();
			$('#subheader .popover').show().animate({'opacity': '1'});
			$('#subheader').animate({'opacity': '1'});
		});
		return false;
	});

	// step 7
	//$('#new-board .popover').show().animate({'opacity': '1'});

    $.urlParam = function(name){
        var match = RegExp('[?&]' + name + '=([^&]*)')
            .exec(window.location.search);
        return match ?
            decodeURIComponent(match[1].replace(/\+/g, ' '))
            : null;
    }
    
});

// Step 2 - rename and delete board
function goHelp2() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.popover .popover-title').text('2. Renommer votre board');
		$('.popover .popover-content').html('Vous pouvez renommer votre board en double cliquant sur le nom ou bien l’éliminer en cliquant sur la croix.<br /><a class="btn color1 next-help2" href="javascript:void(0)" onclick="goHelp3()">Suivant</a>');

		$('.popover').animate({'opacity': '1'}, 400);
	});
	return false;
};

// Step 3 - edit categories
function goHelp3() {
	$('#filters').animate({'opacity': '1'});
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step3').popover({
			title: '3. Modifier les catégories',
			content: 'En cliquant ici, vous pouvez redéfinir les catégories qui vous intéressent pour ce board.<br /><a class="btn color1 next-help4" href="javascript:void(0)" onclick="goHelp4()">Suivant</a>',
			animation: true,
			html: true
		}).popover('show');
	});
	return false;
};

// Step 4 - edit subcategories
function goHelp4() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step4').popover({
			title: '4. Modifier les sous-catégories',
			content: 'Vous pouvez aussi redéfinir les sous-catégories qui vous intéressent pour ce board.<br /><a class="btn color1 next-help5" href="javascript:void(0)" onclick="goHelp5()">Suivant</a>',
			animation: true,
			html: true
		}).popover('show');
	});
	return false;
};

// Step 5 - edit districts
function goHelp5() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step5').popover({
			title: '5. Modifier les arrondissements',
			content: 'De même vous pouvez redéfinir les quartiers que vous fréquentez pour ce board.<br /><a class="btn color1 next-help6" href="javascript:void(0)" onclick="goHelp6()">Suivant</a>',
			animation: true,
			html: true,
            placement: 'left'
		}).popover('show');
	});
	return false;
};

// Step 6 - edit tags
function goHelp6() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step6').popover({
			title: '6. Filtrer plus précisément',
			content: 'Et si vous aimez les choses précises, vous pouvez filtrer encore plus en cliquant ici. <br /><a class="btn color1 next-help7" href="javascript:void(0)" onclick="goHelp7()">Suivant</a>',
			animation: true,
			html: true,
            placement: 'left'
		}).popover('show');
	});
	return false;
};

// Step 7 - Create a new board
/*function goHelp7() {
	$('#filters').animate({'opacity': '0'});
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step7').popover({
			title: '7. Créer un board',
			content: 'Ce bouton vous permet de créer un autre board. <br /><a class="btn color1 next-help8" href="#" onclick="goHelp8()">Suivant</a>',
			animation: true,
			html: true,
			placement: 'bottom'
		}).popover('show');
	});
	return false;
};*/

// Step 8 - Jangalist
function goHelp7() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step8').popover({
			title: '8. Bienvenue dans votre Jangalist.',
			content: 'Vous pouvez y ajouter des produits et des promotions afin de les acheter ou les consulter plus tard.  <br /><a class="btn color1 next-help9" href="javascript:void(0)" onclick="goHelp9()">Suivant</a>',
			animation: true,
			html: true,
			placement: 'bottom'
		}).popover('show');
	});
	return false;
};

// Step 9 - Shops
function goHelp9() {
	$('.popover').animate({'opacity': '0'}, 400, function(){
		$('.help-step9').popover({
			title: '9. Vos magasins',
			content: 'Et en plus vous pouvez suivre vos boutiques préférées à Paris afin d’être tenu au courant des nouveautés. <br /><a class="btn color1" href="javascript:void(0)" onclick="closeHelp()">Fermer</a>',
			animation: true,
			html: true,
			placement: 'bottom'
		}).popover('show');
	});
	return false;
};

function closeHelp() {
	$('#filters').animate({'opacity': '1'});
	$('#subheader').show().animate({'opacity': '1'});
	$('.m-help .popover').animate({'opacity': '0'}, function(){
		$('.m-help .help-cache').animate({'opacity': '0'}, function(){
			$(this).hide();
			$('.help-cache-transparent').remove();
			$('.popover').remove();
			$('body').removeClass('m-help');
            $('.l-header-fullimg').css('z-index', '0');
            $('#header').css('z-index', '1');
		});
	});
    return false;
}

// Change the limit restriction for the "create board link"
function changeCreateBoardLinkLimit(boards_number){
	var create_board_links = $(".new-board a");

	if (boards_number === undefined){
		var boards_number = $("#user-boards .board-link").length;
	}
	if (boards_number < 3){
		// Get the button back to normal
    	create_board_links.attr("data-limit-reached", "false");
    	create_board_links.html("Créer un nouveau board");
    	create_board_links.closest("div").css("margin-left", "-145px");
    	create_board_links.show();
  	} else {
        create_board_links.attr("data-limit-reached", "true");
    }
}
