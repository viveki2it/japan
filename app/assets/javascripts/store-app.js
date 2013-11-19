//= require common
//= require store-app/main
//= require components

/**
 * Global Javascript file
 */


$(document).ready(function () {
    function formErrorHandler (e, response) {
      errors = $.parseJSON(response.responseText);
      $("input", $(e.target)).data('popover', null).removeClass('error');
      $(".popover").remove();
      $.each(errors, function (field, error) {
          $("input[data-error='" + field + "']", $(e.target)).popover({ live:true, placement:'top', trigger:'manual', title:'Erreur', content:error.join('<br/>')}).popover('show');
          $("input[data-error='" + field + "']", $(e.target)).addClass('error');
      })
    }

    function formSuccessHandler (e, data) {
      if (data.location) {
        window.location.href = data.location;
      }
    }

    function bindFormEvents	() {
      $('form[data-remote=true]')
          .off('ajax:error', formErrorHandler)
          .on('ajax:error', formErrorHandler)
          .off('ajax:success', formSuccessHandler)
          .on('ajax:success', formSuccessHandler);
    }

    bindFormEvents();

    // landing inscription
    	// Button profile, buttons that, when clicked, should show a form to create a pro account
    $(".btn-profile").click( function(){
    	// If the user is already signed in, just show an alert
    	if ($(this).data("signedIn")){
    		showAlert("Vous êtes déjà connecté. Merci de vous déconnecter avant de pouvoir vous créer un compte professionnel.");
    	} else {
    		// Otherwise, show the form
    		showDialogCreateProfile();
    	}
    });

    $("#btn-add-shop").click(function(){
        showDialog($("#new-shop"));
    });

    function showDialogCreateProfile() {
        var cache = $('<div class="cache-black"></div>');
        cache.append($('<span class="wrap-icon" id="profile-close"><span class="icon i-cross"></span></span>'));
        cache.append($('<span class="logo-jm"></span>'));
        cache.append($('#signup-section').clone().removeClass('is-white'));
        $('body').append(cache);
        cache.animate({ 'opacity':1 });

        $('#profile-close').click(function () {
            $('.cache-black').animate({ 'opacity':0 }, 300, function () {
                $(this).remove();
                $('.popover').remove();
            });
        });

        bindFormEvents();
        enablePlaceholdersForIE();
    }

    // landing signin
    window.showDialogSignin = function () {
        var cache = $('<div class="cache-black"></div>');
        cache.append($('<span class="wrap-icon" id="profile-close"><span class="icon i-cross"></span></span>'));
        cache.append($('<span class="logo-jm"></span>'));
        if (window.location.pathname == "/users/sign_in") {
            cache.append($('<span class="signin-error">Mauvaise combinaison email et mot de passe</span>'));
        }
        cache.append($('#signin-section').clone().removeClass('hidden'));
        cache.append($('<a href="#" id="btn-switch" class="popup-link">Pas encore inscrit?</a>'));
        cache.append("&nbsp;&nbsp;");
        cache.append($('<a href="/users/password/new" class="popup-link">Mot de passe perdu ?</a>'));
        $('body').append(cache);
        cache.animate({ 'opacity':1 });

        $('#profile-close').click(function () {
            $('.cache-black').animate({ 'opacity':0 }, 300, function () {
                $(this).remove();
                $('.popover').remove();
            });
        });

        $('#btn-switch').click(function () {
            $('.cache-black').animate({ 'opacity':0 }, 300, function () {
                $(this).remove();
                $('.popover').remove();
                showDialogCreateProfile();
            });
        });

        bindFormEvents();
        enablePlaceholdersForIE();
    }
    $("#btn-signin").bind("click", showDialogSignin);
    if (window.location.pathname == '/users/sign_in') {
        window.showDialogSignin();

        enablePlaceholdersForIE();
    }

    // show video
    $('.btn-video').click(function () {
        var cache = $('<div class="cache-black"></div>');
        cache.append($('<span class="wrap-icon" id="profile-close"><span class="icon i-cross"></span></span>'));
        cache.append($('<span class="logo-jm"></span>'));
        cache.append($('<div class="video-wrap"><iframe id="video-jangala" src="http://player.vimeo.com/video/50641155?title=1&amp;byline=1&amp;portrait=1&amp;autoplay=1" width="68%" height="489px" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>').clone());

        // right height for video
        $('#video-jangala').height(parseInt($('#video-jangala').width() / 1.77935943))

        $('body').append(cache);
        cache.animate({ 'opacity':1 });

        $('#profile-close').click(function () {
            $('.cache-black').animate({ 'opacity':0 }, 300, function () {
                $(this).remove();
            });
        });
    });

    // Collapse on FAQ page
    $(".accordion").collapse();

    

    // custom Dialog
    function showDialog($item) {
        var cache = $('<div class="cache-black"></div>');
        cache.append($('<span class="wrap-icon" id="profile-close"><span class="icon i-cross"></span></span>'));
        cache.append($('<span class="logo-jm"></span>'));
        cache.append($item.clone().show().removeClass('dnone'));
        $('body').append(cache);
        cache.animate({ 'opacity':1 }, 300, function(){
        	// fix the content behind the modal
            $('#header, #container, #footer, #signin-section').css('position', 'fixed');
            $('.cache-black').css({'position': 'absolute', 'height': 'auto', 'min-height': '100%'});

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

        bindFormEvents();
        enablePlaceholdersForIE();
    }


});
