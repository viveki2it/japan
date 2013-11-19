$(document).ready(function () {
	
	// Add to Jangalist
	$('#btn-jangalist').click(function() {
		if( $(this).data("deactivated") !== true) {
	    	if( !$(this).hasClass('active') ) {
		    	$(this).addClass('active').html('<i class="icon i-tick"></i> Jangalist');
		    	$.get(window.location.pathname+'/to_jangalist');
		    	showAlert('Ce produit a bien été rajouté à la Jangalist.', 5000);
		    } else {
		    	$(this).removeClass('active').html('+ Jangalist');
		    	$.ajax({type:'DELETE',url:window.location.pathname+'/from_jangalist'});
		    }
		}
		return false;
	});
});