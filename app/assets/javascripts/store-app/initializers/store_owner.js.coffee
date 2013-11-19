add_forms = {}
Nextdoorz.Initializers.StoreOwner = ()->
  self = @

  @news = new Nextdoorz.Collections.News {store_id: Context.current_user.store_id}
  @news.fetch()
  @deals = new Nextdoorz.Collections.Deals {store_id: Context.current_user.store_id}
  @deals.fetch()
  @products = new Nextdoorz.Collections.Products {store_id: Context.current_user.store_id}
  @products.fetch()
  @store = new Nextdoorz.Models.Store {id: Context.current_user.store_id }
  @store.fetch success: (store)->
    Context.store = store

  @tags = new Nextdoorz.Collections.Tags {store_id: Context.current_user.store_id}
  @tags.fetch success: (tags)->
    Context.tags = tags
  
  $('.editable .control-buttons a, .store-edit-button').on 'click', (e)->
    e.preventDefault()
    popupName = $(this).attr('popup')
    if popupName == 'edit' || popupName == 'delete'
      if item_id = $(this).closest('.editable').attr('id')
        type = item_id.split('_')[0]
        id = item_id.split('_')[1]
        element = $(this).closest('.editable')
        if popupName == 'edit'
          popup = new Nextdoorz.Views["New#{type.capitalize()}"] model: self[type].get(id), tags: self.tags.models
          popup.render()
        else if popupName == 'delete'
          popup = new Nextdoorz.Views.Confirm(model: self[type].get(id), html_tag: element)
          popup.render()
    else
      popup = new Nextdoorz.Views["StoreEdit#{popupName.capitalize()}"] model: $.extend(true, {}, Context.store)
      popup.render()

    false
  $('[contenteditable="true"]').on 'blur', ()->
    $('p:empty', this).remove()
    
    Context.store.set this.id, if this.id == 'phone' then $(this).text() else $(this).html()
    Context.store.save()
    

  ####  new Nextdoorz.Views.PaginatedView(
  #  collection: new Nextdoorz.Collections.News,
  #  el: '.news.top.list'
  #)###o
  $('.editable').on 'mouseover', ()->
    $('.hidden-edit', this).css('width', $(this).css('width'))
    $('.hidden-edit', this).css('height', $(this).css('height'))
    $('.hidden-edit', this).css('line-height', $(this).css('height'))
    $('.hidden-edit', this).show()
    $(this).addClass('hover')
  $('.editable').on 'mouseout', ()->
    $('.hidden-edit', this).hide()
    $(this).removeClass('hover')

  _.each ["news", "deals", "products"], (item)->
    $('body').on 'click', "a.add_#{item}", ()->

      add_forms[item] ||= new Nextdoorz.Views["New#{item.capitalize()}"] tags: self.tags.models
      add_forms[item].render()
      false

