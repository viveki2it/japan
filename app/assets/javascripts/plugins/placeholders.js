// placeholder for old browsers
$(document).ready(function () {
	enablePlaceholdersForIE();
});

function enablePlaceholdersForIE(inputs) {
	if(inputs === undefined){
		inputs = $("input, textarea");
	};
	
	if (!Modernizr.input.autofocus) {
	    inputs.each(function(){
			if ($(this).attr('autofocus'))
				$(this).focus();
		});
	}
	if (!Modernizr.input.placeholder) {
        inputs.each(function(){
			if ($(this).attr('placeholder')) {
				var placeholder_text = $(this).attr('placeholder');
				$(this).addClass('nc');
				if($(this).attr("type") == "password"){
					$(this).popover({
						html: true,
						content: "<p>" + placeholder_text + "</p>"
					});
				} else {
					$(this).val(placeholder_text);	
				}
			}
		});

		// for all fields with uncleared initial value, on focus
		$('.nc').focus(function() {

			// if it is uncleared
			if ($(this).hasClass('nc')) {

				// remeber the initial value
				$textbox = $(this).val();

				// and remove it
				$(this).removeClass('nc').val('');
			}
		}).focusout(function() { // on focus out

			// if there is no new value posted by user
			if ($(this).val() == '')

				// mark as uncleared and show initial value
				$(this).addClass('nc').val($textbox);
		});
   }
    
}