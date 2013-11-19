class Nextdoorz.Views.UpdateBoardSubcategory extends Nextdoorz.Views.NewBoardSubcategory
  nextViewName: undefined
  prevViewName: 'UpdateBoardCategory'
  className: 'u-step2'
  template: Nextdoorz.getTemplate('boards/wizard/subcategory')
  _modelToView: ()->
    view = this
    @$('.checkbox-subcat').each ()->
      view._offSelectedLook $(this)
    cBoardSubcats =  @model.get('categories')
    cBoardSubcats.each (cat)->
      $catCheckbox = view.$("#category_#{cat.id}")
      if $catCheckbox.length
        view._onSelectedLook $catCheckbox
      else
        cBoardSubcats.remove(cat.id)
  beforeShow: ()->
    @render()
    @_modelToView()
    true
  events:
    'click fieldset .checkbox-subcat': '_toggleSelectionOne'
    'click .checkbox-subcat.all': '_toggleSelectionAll'

  _onSelectedLook: ($item)->
    $item.addClass 'checked'
    $('.i-tick', $item).removeClass 'dnone'

  _offSelectedLook: ($item)->
    $item.removeClass 'checked'
    $('.i-tick', $item).addClass 'dnone'

  _toggleSelectedLook: ($item)->
    $item.toggleClass 'checked'
    $('.i-tick', $item).toggleClass 'dnone'

  _addAllToBoard: ()->
    aAllSubcats = []
    @model.get('category_parents').each (cat_parent)->
      cat_parent.get('categories').each (cat)->
        aAllSubcats.push cat.attributes
    @model.get('categories').reset aAllSubcats

  _removeAllFromBoard: ()->
    @model.get('categories').reset()

  _togglePresenceOnBoard: (mSubcat)->
    cSubcatsOnBoard = @model.get 'categories'
    unless cSubcatsOnBoard.get mSubcat.id
      cSubcatsOnBoard.add mSubcat.attributes
    else
      cSubcatsOnBoard.remove mSubcat.id

  _toggleSelectionOne: (e)->
    $item = $(e.currentTarget)
    @_toggleSelectedLook $item

    sId = $item.attr('id')
    id = parseInt sId.slice(sId.lastIndexOf('_') + 1, sId.length), 10

    mSubcat = Nextdoorz.Cache.Categories.get id
    @_togglePresenceOnBoard mSubcat
    false

  _toggleSelectionAll: (e)->
    $all_button = $(e.currentTarget)
    if $all_button.hasClass 'checked'
      @_offSelectedLook @$('.checkbox-subcat')
      @_removeAllFromBoard()
    else
      view = this
      @$('.checkbox-subcat').each ()->
        view._onSelectedLook($(this))
      @_addAllToBoard()
    false
