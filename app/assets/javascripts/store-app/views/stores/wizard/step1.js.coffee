class Nextdoorz.Views.ProfileWizardStep1 extends Backbone.View
  modelBinder: new Backbone.ModelBinder()
  template: Nextdoorz.getTemplate('stores/wizard/step1')
  hasValidator: true
  events:
    {
    'click .categories': 'updateDropdown',
    'click .checkbox-subcat': '_toggleSelectionOne'
    }

  _toggleSelectionOne: (e)->
    $item = $(e.currentTarget)
    @_toggleSelectedLook $item
    false

  _toggleSelectedLook: ($item)->
    $item.toggleClass 'checked'
    $('.i-tick', $item).toggleClass 'dnone'

  render: ()->
    $el = @$el
    $model = @model

    $el.html @template {
      model: @model,
      categories: Nextdoorz.categories.models,
      parent_categories: Nextdoorz.category_parents.models
    }

    $el.modal()

    modal_body = @$(".categories")
    modal_body.width("900px")
    modal_body.css("left", "-70px")

    $el.on 'hidden', ()->
      $el.remove()

    this

  prepare: ()->
    $el = @$el
    associations_attributes = _.map $('.checkbox-subcat.checked>span'), (item) =>
      {category_id: $(item).attr('category')}
    @model.set 'categories_associations', associations_attributes if associations_attributes
    @model

  markBigButtonAsActive: (btn)->
    @$('.categories .btn').each ()->
      $(this).removeClass 'active'
    $(btn).addClass 'active'

  updateDropdown: (e)->
    # if click on icon, change this into the parent (.btn)
    if $(e.target).hasClass('icon')
      $btnClicked = $(e.target).parent()
    else
      $btnClicked = $(e.target)

    view = this
    view.markBigButtonAsActive $btnClicked
    $('#subcategories').removeClass('dnone')
    isDefaultSet = false
    $('.checkbox-subcat').each (item)->
      if $(this).attr('parent_category_id') == "category_"+$btnClicked.attr('category_id')
        $(this).show()
      else
        $(this).hide()

  isValid: ()->
    @$('.categories .btn.active').size() == 1
