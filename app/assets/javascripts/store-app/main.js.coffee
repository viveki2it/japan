#= require ./model_binder
#= require ./collection_binder
#= require_self
#= require ./models/index
#= require_directory ./collections
#= require_tree ./templates
#= require ./views/index
#= require_directory ./initializers
window.Nextdoorz =
  type: 'store'
  Models:
    {}
  Collections:
    {}
  Views:
    {}
  Initializers:
    {}
  mixins:
    {}
  init: () ->
    add_news_form = undefined
    @categories = new Nextdoorz.Collections.Categories
    @categories.reset(Context.categories)

    @category_parents = new Nextdoorz.Collections.CategoryParents
    @category_parents.reset(Context.category_parents)
    Nextdoorz.Initializers.General()
    if Context.current_user
      if Context.current_user.wizard_step != 0
        Nextdoorz.Initializers.ProfileWizard()
      if Context.current_user.role = 'store_owner'
        if Context.controller is 'stocks'
          Nextdoorz.Initializers.Stocks()
        else
          Nextdoorz.Initializers.StoreOwner()

    $('.picture.middle').each (idx, item)->
      new Nextdoorz.Views.ShowPicture el: item
    $('a.modal-link').on 'click', ()->
      $this = $(this)
      $('body').append (new Nextdoorz.Views.Modal url: $this.attr('href'), title: $this.html()).render().el
      false
  getTemplate: (path)->
    JST['store_app/templates/' + path]
$(document).ready ->
  Nextdoorz.init()
