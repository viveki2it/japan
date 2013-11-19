class Nextdoorz.Views.StoreEditCategory extends Backbone.View
  modelBinder: new Backbone.ModelBinder()
  template: Nextdoorz.getTemplate('stores/edit/category')
  events:
    'click .save': "submitModel"
    'click .categories': 'updateDropdown'
    'click .checkbox-subcat': '_toggleSelectionOne'

  isCategoryChecked: (category) =>
    _.find @current_categories, (item) =>
      item.id == category.attributes.id

  _toggleSelectionOne: (e)->
    item = $(e.currentTarget)
    item.toggleClass 'checked'
    $('.i-tick', item).toggleClass 'dnone'
    @updateAssociations(item)
    false

  updateAssociations: (item) ->
    category_id = $('span', item).attr('category')
    checked = item.hasClass('checked')
    alreadyExists = _.any @associations, (association) ->
      "#{association.category_id}" == "#{category_id}"

    if checked and !alreadyExists
      @associations.push {category_id: category_id}
    else
      _.each @associations, (association) ->
        if "#{association.category_id}" == "#{category_id}"
          association['_destroy'] = !checked

  updateDropdown: (e)->
    # if click on icon, change this into the parent (.btn)
    if $(e.target).hasClass('icon')
      $btnClicked = $(e.target).parent()
    else
      $btnClicked = $(e.target)

    @markBigButtonAsActive $btnClicked
    $('#subcategories').removeClass('dnone')
    $('.checkbox-subcat').each (item)->
      if $(this).attr('parent_category_id') == "category_"+$btnClicked.attr('category_id')
        $(this).show()
      else
        $(this).hide()

  markBigButtonAsActive: (btn)->
    @$('.categories .btn').each ()->
      $(this).removeClass 'active'
    $(btn).addClass 'active'


  render: ()->
    $el = @$el
    $model = @model
    @current_categories = @model.get 'categories'
    @associations = @model.get 'categories_associations'
    $el.html @template {
    view: this
    model: @model
    current_categories: @current_categories
    categories: Nextdoorz.categories.models
    parent_categories: Nextdoorz.category_parents.models
    }

    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    this

  submitModel: ()->
    $el = @$el
    @model.set 'categories_associations', @associations

    @model.save {},
      {
      success: (response)->
        $el.modal 'hide'
        #need recieve category as text
        location.reload()
      }
