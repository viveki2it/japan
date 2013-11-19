$ ->
  # Deactivate button that should be deactivated
  $("[data-deactivated=true]").click(
    (event) ->
      event.preventDefault()
      event.stopPropagation()
      return false
  )
  
  ###
  # Pop up on specific buttons
  # Some buttons required the user to be signed in, so if a user click on
  # one of them and he is not signed in, then we show the sign up pop up
  ###
  $("a[data-signed-in-required='true']").click(
    (event) ->
      url = $("#btn-user-connect.signup-mode").attr("href")
      showAlert("Cette fonctionnalité nécessite que vous soyez inscrit ou connecté. Vous allez être redirigé.")
      window.location.href = url
      event.preventDefault()
      return false
  )