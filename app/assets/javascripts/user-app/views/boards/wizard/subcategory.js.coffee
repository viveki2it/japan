class Nextdoorz.Views.NewBoardSubcategory extends Nextdoorz.Views.BaseWizardStep
  title: "Affinez vos préférences"
  nextViewName: 'NewBoardDistrict'
  prevViewName: 'NewBoardCategory'
  className: 'u-step2'
  template: Nextdoorz.getTemplate('boards/wizard/subcategory')
  _modelToView: ()->
    view = this
    @$('.checkbox-subcat').each ()->
      view._offSelectedLook $(this)
    cBoardSubcats =  @model.get('categories')
    if @model.is_new
      # TODO: comprendre pourquoi par défaut toutes les sous-catégories sont sélectionnées...
      @_removeAllFromBoard()
    else
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

  beforeSwitch: ()->
    @model.afterCategoryChange()


  events:
    'click fieldset .checkbox-subcat': '_toggleSelectionOne'
    'click .checkbox-subcat.all': '_toggleSelectionAll'

  _onSelectedLook: ($item)->
    $item.addClass 'checked'
    $('.i-tick', $item).removeClass 'dnone'    

  _offSelectedLook: ($item)->
    $item.removeClass 'checked'
    $('.i-tick', $item).addClass 'dnone'

  _onAllButton: ()->
    $('.all.checkbox-subcat').addClass 'checked'
    $('.all.checkbox-subcat .i-tick').removeClass 'dnone'

  _toggleSelectedLook: ($item)->
    $item.toggleClass 'checked'
    $('.i-tick', $item).toggleClass 'dnone'
    $all_button_to_check = true;
    $all_button_to_uncheck = true;

    #@_onAllButton 
    if $item.hasClass 'checked'
      $('div.checkbox-subcat').each ()->
        if !$(this).hasClass 'checked'
          $all_button_to_check = false;
      if $all_button_to_check        
        $('.all.checkbox-subcat').addClass 'checked'
        $('.all.checkbox-subcat .i-tick').removeClass 'dnone' 
        
    #@_offAllButton 
    else
      $('div.checkbox-subcat').each ()->
        if $(this).hasClass 'checked'
          $all_button_to_uncheck = false;
      if $all_button_to_uncheck
        #@_onAllButton 
        $('.all.checkbox-subcat').removeClass 'checked'
        $('.all.checkbox-subcat .i-tick').addClass 'dnone'

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
