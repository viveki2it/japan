class Nextdoorz.Views.NewBoardTag extends Nextdoorz.Views.BaseWizardStep
  title: "Qu'est-ce qui vous intéresse ?"
  nextViewName: undefined
  prevViewName: undefined
  className: 'u-step4'
  template: Nextdoorz.getTemplate('boards/wizard/tag')
  events:
    #'click .checkbox-tag.all-tags': '_toggleSelectionAll'
    'change .checkbox-tag.one-tag': '_updateSelection'
    'click .m-tags-edit .tag label': '_clickTag'
    
  _modelToView: ()->
    view = this
    @$('.checkbox-tag').each ()->
      view._offSelectedLook $(this)
    cBoardTags = @model.get('tags')
    cBoardTags.each (tag)->
      $tagCheckbox = view.$(".tag .checkbox-tag.tag-#{tag.id}")
      if $tagCheckbox.length
        view._onSelectedLook $tagCheckbox
    cBoardTagGroups = @model.get('tag_groups')
    
    cBoardTagGroups.each (tagg)->
      $tagCheckboxes = view.$(".tag .one-tag.checkbox-tag.tag_group-#{tagg.id}")
      $tagCheckedBoxes = view.$(".tag .one-tag.checkbox-tag.tag_group-#{tagg.id}:checked")
      if $tagCheckboxes.length == $tagCheckedBoxes.length
        view._onSelectedLook view.$(".tag .all-tags.checkbox-tag.tag_group-#{tagg.id}")
    

  beforeShow: ()->
    @render()
    @_modelToView()
    true

  beforeSwitch: ()->
    aAllTags = []
    @$(".tag .one-tag.checkbox-tag:checked").each ()->
      aAllTags.push (Nextdoorz.Cache.Tags.get $(this).attr('data-tag-id')).attributes
    @model.get('tags').reset aAllTags
    @model.afterTagChange()

  _onSelectedLook: ($item)->
    $item.attr('checked', true);
    $('.i-tick', $item).removeClass 'dnone'
    $item.parent().addClass('is-active');

  _offSelectedLook: ($item)->
    $item.removeAttr('checked');
    $item.parent().removeClass('is-active');
    $('.i-tick', $item).addClass 'dnone'

  _toggleSelectedLook: ($item)->
    if $item.attr('checked')
      $item.removeAttr('checked');
      $item.parent().removeClass('is-active');
    else
      $item.attr('checked', true);
      $item.parent().addClass('is-active');
    $('.i-tick', $item).toggleClass 'dnone'

  _clickTag: (e)->
    input = $(e.currentTarget).find("input")
    if $(e.currentTarget).hasClass('is-active')
      input.prop("checked", false)
      $(e.currentTarget).removeClass('is-active');
    else
      input.prop("checked", true)
      $(e.currentTarget).addClass('is-active');
    $(e.currentTarget).find("input").change()
    
    if $(e.currentTarget).hasClass("total")
      @_toggleSelectionAll(input)
    return false

  _updateSelection: (e)->
    tagGroupId = $(e.currentTarget).attr('data-tag-group-id')
    $tagCheckboxes = @$(".tag .one-tag.checkbox-tag.tag_group-#{tagGroupId}")
    $tagCheckedBoxes = @$(".tag .one-tag.checkbox-tag.tag_group-#{tagGroupId}:checked")
    
    if $tagCheckboxes.length == $tagCheckedBoxes.length
      @_onSelectedLook @$(".tag .all-tags.checkbox-tag.tag_group-#{tagGroupId}")
    else
      @_offSelectedLook @$(".tag .all-tags.checkbox-tag.tag_group-#{tagGroupId}")
    
    true

  _toggleSelectionAll: (button)->
    $all_button = button
    tag_group_id = $all_button.attr('data-tag-group-id')
    if $all_button.prop('checked')
      @_onSelectedLook @$(".one-tag.checkbox-tag.tag_group-#{tag_group_id}")
    else
      @_offSelectedLook @$(".one-tag.checkbox-tag.tag_group-#{tag_group_id}")
    true
