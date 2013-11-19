
$ ->
  # Recommend window: 
  recommend = $(".m-recommend")
  notification = $("#recommend_form").find(".form-notification")
  
  # Recommend button, to show the recommend window
  $("#btn-recommend").click(
    (event) -> 
      if( $(this).data("deactivated") isnt true)
        current_url = window.location.pathname
        #showDialog(recommend)
        recommend.show()
        $("body").css("overflow", "hidden")
        window.scrollTo(0, 0)
      return false;
  )
  
  $("#recommend-close").click(
    (event) ->
      recommend.hide()
      $("body").css("overflow", "")
      
  )
  
  $("#recommend_form").bind("ajax:success", 
    (xhr, data, status) ->
      notification.html("Envoi du mail réussi").show().delay(5000).hide(500)   
  ).bind("ajax:error",
    (xhr, data, status) ->
      notification.html("Echec de l'envoi du mail").show().delay(5000).hide(500)
  )
