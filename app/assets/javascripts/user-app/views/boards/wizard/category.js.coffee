class Nextdoorz.Views.NewBoardCategory extends Nextdoorz.Views.BaseWizardStep
  className: 'u-step1'
  template: Nextdoorz.getTemplate('boards/wizard/category')
  title: "Choisissez vos tendances"
  nextViewName: 'NewBoardSubcategory'
  prevViewName: undefined
  events:
    'click .checkbox-cat': '_labelClick'

  beforeShow: ()->
    super
    @_modelToView()
    $(".stores-examples").show()
    true

  _toggleSelection: ($element)->
    $element.toggleClass 'checked'
    $('.i-tick', $element).toggleClass 'dnone'


  _modelToView: ()->
    view = this
    @$('.checkbox-cat').removeClass 'checked'
    @$('.checkbox-cat .i-tick').addClass 'dnone'
    @model.get('category_parents').each (cat)->
      view._toggleSelection view.$("#category_#{cat.id}")

  _labelClick: (e)->
    $element = $(e.currentTarget)

    @_toggleSelection $element

    id = parseInt $element.attr('data-category-id')

    cBoardCatParents = @model.get('category_parents')
    unless cBoardCatParents.get id
      mCatParent = Nextdoorz.Cache.CategoryParents.get id
      cBoardCatParents.add mCatParent.attributes # copy, not the same object
    else
      cBoardCatParents.remove id

    false

  beforeSwitch: ()->
    @model.afterParentCategoryChange()
    $(".stores-examples").hide()
    true