#= require_directory ./wizard
class Nextdoorz.Views.UpdateBoardCategories extends Nextdoorz.Views.BaseWizard
  initialViewName: 'UpdateBoardCategory'
  template: Nextdoorz.getTemplate('boards/update_categories')
  stepHolderSelector: '.u-steps'
  events:
    'click #save': 'nextStep'
    'click #back': 'prevStep'
  finishWizard: ()->
    that = this
    $('#update_container').empty().hide()
    that.showLoader()
    @model.save {}, success: (model)->
      Nextdoorz.Cache.Boards.fetch success: ()->
        that.hideLoader()
        # Navigate back to the boards index
        Nextdoorz.Routers.Boards.boards_index model.id
        showAlert('Votre filtre a été mis à jour', 500)
    super
  afterViewChange: ()->
    @_updateButtons()
    @_updateTitle()
    super
  _updateTitle: ()->
    @$('h2').text @currentView.title
  _updateButtons: ()->
    $back = @$('#back')
    if @currentView.prevViewName
      $back.removeClass 'dnone'
    else
      $back.addClass 'dnone'