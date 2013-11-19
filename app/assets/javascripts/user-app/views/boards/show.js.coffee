class Nextdoorz.Views.ShowBoard extends Nextdoorz.View
  # This file sets the views for the user board
  template: Nextdoorz.getTemplate('boards/show')
  events:
    "click .filter-cats": 'cat_update'
    "click .filter-subcats": 'subcat_update'
    "click .filter-tags": 'tag_update'
    "click .filter-districts": 'district_update'
    "click #store-email-post-button": 'send_invitation'

  # Called on scroll event. This event must be attached to the window
  # that's why it doesn't appear in events.
  checkScroll: (event, that) ->
    scroll_max_y  = window.scrollMaxY
    scroll_top    = window.scrollY
    if scroll_top is undefined
      scroll_top = (document.documentElement || document.body.parentNode || document.body).scrollTop;
    if scroll_max_y is undefined
      scroll_max_y = document.documentElement.scrollHeight - document.documentElement.clientHeight
      
    test_point = scroll_max_y - @triggerPoint
    if ( !that.isLoading && (scroll_top > test_point))
      @loadNexts()

  loadNexts: () ->
    view = this
    model = @model
    # This function will add next @items_per_load items in the column
    view.isLoading = true
    $(".m-infinite-scroll").show()

    # This will perform a GET request to boards/board_id page.
    # In this application, it is associated to the boards_controller/show view
    # The view sends back a lot of JSON parsed datas, which can be seen in the corresponding .rabl view
    # Look at the templates/boards/show.hamlc view to see how boards are rendered
    @model.fetch success: (model, response, options) ->
      view.appendNextItems()
      view.isLoading = false
      $(".m-infinite-scroll").hide()

      if view.nbItems > 0
        model.page += 1
      else
        $(window).off("scroll")

  # Append next items to each list when changing page on infinite scroll
  appendNextItems: () ->
    @_prepareItemListViews()

    if @nbItems > 0
      _.each @cache, (view)->
        view.renderItems(@$(view.itemsListSelector))

  # Send an invitation to a store
  send_invitation: () ->
    mail_input = @$("#store-email-field")
    store_mail = mail_input.val()
    mail_input.popover({
      placement: "top",
      title: "Erreur",
      content: "Merci d'indiquer un e-mail valide" 
    })
    
    # If the mail is not empty, send an invitation
    # TestMailAddress is defined in common.js
    if testMailAddress(store_mail)
      $.post("/users/send-store-invitation", 
        {email: store_mail},
        success: () ->
          showAlert("Email envoyé avec succès")
        error: () ->
          showAlert("Erreur lors de l'envoi du mail")
      )
      mail_input.popover("destroy")
    else
      mail_input.popover('show')
    false

  # Called when updating categories
  cat_update: ()->
    $container = $('#update_container').empty().hide()
    update_view = new Nextdoorz.Views.UpdateBoard model: @model, child_view_name: "NewBoardCategory", el: $container
    update_view.type_name = 'catégories'
    update_view.el_class = 'user-categories'
    update_view.render().$el.slideToggle()
    false

  # Called when updating sub categories
  subcat_update: ()->
    $container = $('#update_container').empty().hide()
    update_view = new Nextdoorz.Views.UpdateBoard model: @model, child_view_name: "NewBoardSubcategory", el: $container
    update_view.type_name = 'catégories'
    update_view.el_class = 'user-categories'
    update_view.render().$el.slideToggle()
    $('.u-step2').show() #dirty, see how to fix properly
    false

  # Called when updating tags
  tag_update: ()->
    $container = $('#update_container').empty().hide()
    update_view = new Nextdoorz.Views.UpdateBoard model: @model, child_view_name: "NewBoardTag", el: $container
    update_view.type_name = 'tags'
    update_view.el_class = 'user-tags'
    update_view.render().$el.slideToggle()
    false

  # Called when updating districts
  district_update: ()->
    $container = $('#update_container').empty().hide()
    update_view = new Nextdoorz.Views.UpdateBoard model: @model, child_view_name: "NewBoardDistrict", el: $container
    update_view.type_name = "arrondissements"
    update_view.el_class = "user-districts"
    update_view.render().$el.slideToggle()
    false

  # Sort of before show callback.
  beforeShow: ()->
    view = this
    model = @model

    $(".m-loader.board-loader").show()
    model.page = 1

    # This will perform a GET request to boards/board_id page.
    # In this application, it is associated to the boards_controller/show view
    # The view sends back a lot of JSON parsed datas, which can be seen in the corresponding .rabl view
    # Look at the templates/boards/show.hamlc view to see how boards are rendered

    model.fetch(
      success: (model, response, options) ->
        view.render()
        model.page += 1
      , error: (model, xhr, options) ->
        errors = $.parseJSON(xhr.responseText).errors

        showAlert(errors["board"])
    )


  _prepareItemListViews: ()->
    # See corresponding views/models/_list.js.coffee to see what those views are
    @cache['products'] = new Nextdoorz.Views.ProductsList(collection: @model.get('products'), title: "Top produits", board: @model)
    @cache['deals'] = new Nextdoorz.Views.DealsList(collection: @model.get('deals'), title: "Top promotions", board: @model)
    @cache['news'] = new Nextdoorz.Views.NewsList(collection: @model.get('news'), title: "Top actualités", board: @model)

    @nbItems = @model.get('products').length + @model.get('deals').length + @model.get('news').length

  initialize: () ->
    ## Scroll loading variables
    # Is loading is a flag that will allow us to prevent
    # the app loading more than one loading block at a time
    @isLoading = true
    @triggerPoint = 150 # will trigger 150px from the bottom

    super()

  
  leave: ()->
    $(window).off("scroll")
    #unless Context.current_user
    #  $('#btn-user-connect.signin-mode').show()
    #  $('#btn-user-connect.signup-mode').hide()

  # Main function to render the view
  # Called when rendering a board
  render: ()->
    model = @model
    that = this
    
    @$el.html @template(board: @model)

    # items_list is the wrapper containing all lists
    $itemsList = @$('#items_list')
    $itemsList.empty()
    @_prepareItemListViews()

    # This will append item lists to the corresponding column of the board thanks the the "cache" variable
    if @nbItems > 0
      _.each @cache, (view)->
        $itemsList.append view.render().$el

    # This will change the URL of the browser
    Backbone.history.navigate "boards/#{model.id}"

    $(".m-loader.board-loader").hide()
    $(".m-infinite-scroll").hide()

    if @nbItems > 0
      $(window).on("scroll",
        (event) ->
          that.checkScroll(event, that)
      )

    #unless Context.current_user
    #  $('#btn-user-connect.signin-mode').hide()
    #  $('#btn-user-connect.signup-mode').show()

    @isLoading = false

    this