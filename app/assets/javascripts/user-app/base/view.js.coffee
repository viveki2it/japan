class Nextdoorz.View extends Support.CompositeView
  cache: undefined
  events:
    'click .btn-follow': 'follow_shop'
    'click .is-following': 'unfollow_shop'
  
  # Function used to follow a shop
  follow_shop: (e)->
    # If the user is not signed in (no current user), then show the sign up popin
    unless Context.current_user
      e.preventDefault()
      $("#btn-user-connect.signup-mode").click()
      return false

    # We get all the displayed buttons of the store using their store-id data attribute
    store_id = $(e.currentTarget).data("store-id")
    store_name = $(e.currentTarget).data("store-name")
    buttons = $(".btn-follow[data-store-id='" + store_id + "']")
    e.preventDefault()

    # For each button turn them as "is following"
    buttons.each(
      ->
        button = this
        i_tag = $(button).find('i')

        $(button).removeClass('btn-follow')
        $(button).addClass('is-following')
        $(button).find('span').text('Vous suivez ' + store_name)

        i_tag.text('-')
        i_tag.removeClass("yellow")
    )


    # Perform the ajax request to follow the store
    $.get("/stores/" + store_id + "/follows/new.json")

    return false

  # Function used to unfollow a shop
  unfollow_shop: (e) ->
    # We get all the displayed buttons of the store using their store-id data attribute
    store_id = $(e.currentTarget).data("store-id")
    buttons = $(".is-following[data-store-id='" + store_id + "']")
    e.preventDefault()

     # For each button turn them as "is following"
    buttons.each(
      ->
        button = this
        i_tag = $(button).find('i')

        $(button).removeClass('is-following')
        $(button).addClass('btn-follow')
        $(button).find('span').text('Suivre')
        i_tag.text('+')
        i_tag.addClass("yellow")
    )

    $.ajax({
        url: "/stores/" + store_id + "/follows.json",
        type: 'DELETE',
        success: (result) ->
          # Do something with the result

    })

    return false
  
  # These functions return false if operation can't be continued (i.e. input not valid)
  beforeHide: ()-> true
  beforeShow: ()->
    @render() if @$el.html() == ''
    true
  beforeSwitch: ()-> true
  afterSwitch: ()-> true
  showLoader: (message) ->
    loader = $(".m-loader")
    if message
      loader.prepend("<p>" + message + "</p>")
    loader.show()
  hideLoader: () ->
    loader = $(".m-loader")
    loader.find("p").remove()
    loader.hide()
  initialize: ()->
    @cache = Nextdoorz.Cache.byCid[@cid] = {}
    enablePlaceholdersForIE
    super
  leave: ()->
    Nextdoorz.Cache.byCid[@cid] = undefined
    super
