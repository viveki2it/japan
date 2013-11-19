class Nextdoorz.Views.Signin extends Nextdoorz.View
  template: Nextdoorz.getTemplate('signin/signin')

  events:
    "click .icon.i-cross": 'back'
    "ajax:error .signup-signin": 'ajax_error'
    "ajax:success .signup-signin": 'ajax_success'
    "ajax:beforeSend .signup-signin": 'ajax_before'

  back: ()->
    Backbone.history.navigate "/boards", trigger: true
    #window.history.back()

    this

  ajax_before: (e)->
    $("input", $(e.target)).removeClass "error"
    $(".popover").remove()

    return true


  ajax_error: (e, response)->
    error = $.parseJSON(response.responseText)['error']
    $("input", $(e.target)).addClass "error"
    $(".btn", $(e.target)).popover(
        live: true
        placement: "right"
        trigger: "manual"
        title: "Erreur"
        html: true
        content: "<p>" + error + "</p>"
      ).popover "show"

    this

  ajax_success: (e, response)->
    @success(response.id, response.location)

    this

  goto_user_home: (url)->
    window.location.href = url

    this

  display_facebook_error: ()->
    error = $.urlParam 'error'
    #TODO trouver une facon plus propre de clean l'url
    Backbone.history.navigate "", trigger: false
    Backbone.history.navigate "/signin", trigger: false
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

  success: (user_id, url)->
    @goto_user_home(url)

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
