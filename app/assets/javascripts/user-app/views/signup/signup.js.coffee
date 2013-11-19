class Nextdoorz.Views.Signup extends Nextdoorz.View
  template: Nextdoorz.getTemplate('signup/signup')

  events:
    "click .icon.i-cross": 'back'
    "click .btn-switch": 'switch'
    "ajax:error .email-connexion.signup-signin": 'ajax_error'
    "ajax:success .email-connexion.signup-signin": 'ajax_success'

  back: ()->
    Backbone.history.navigate "/boards", trigger: true

    this

  switch: ()->
    $('#signup-modal .email-connexion').slideToggle();
    $('#signup-modal .facebook-connexion').slideToggle();
    $(".popover").remove()
    this

  ajax_error: (e, response)->
    errors = $.parseJSON(response.responseText)
    $("input", $(e.target)).data("popover", null).removeClass "error"
    $(".popover").remove()
    $.each errors, (field, error) ->
      $("input[name='user[" + field + "]']", $(e.target)).popover(
        live: true
        placement: "top"
        trigger: "manual"
        title: "Erreur"
        content: error.join("<br/>")
      ).popover "show"
      $("input[name='user[" + field + "]']", $(e.target)).addClass "error"

  ajax_success: (e, response)->
    @success response.id

    this

  goto_user_home: ()->
    window.location.href = '/user/boards'

    this

  display_facebook_error: ()->
    error = $.urlParam 'error'
    #TODO trouver une facon plus propre de clean l'url
    Backbone.history.navigate "", trigger: false
    Backbone.history.navigate "/signup", trigger: false
    #TODO caller sur le bon event, au lieu de faire un timeout
    if error
      setTimeout((()->
        $(".btn.facebook").popover(
          live: true
          html: true
          placement: "top"
          trigger: "manual"
          title: "Erreur"
          content: "<p>" + error + "</p>"
        ).popover "show"),
        2000)

    this

  success: (user_id)->
    @goto_user_home()

    this


  render: ()->
    model = @model
    @$el.html @template(data: @model)
    @display_facebook_error()
    
    $("body").css("overflow", "hidden");
    enablePlaceholdersForIE(@$("input"))

    this

  leave: ()->
    $("body").css("overflow", "");
