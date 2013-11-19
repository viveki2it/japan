#= require_directory ./wizard
class Nextdoorz.Views.NewBoard extends Nextdoorz.Views.BaseWizard
  initialViewName: 'NewBoardCategory'
  template: Nextdoorz.getTemplate('boards/new')
  stepHolderSelector: '.u-steps'
  events:
    'click #save': 'nextStep'
    'click #back': 'prevStep'
  finishWizard: ()->
    that = this
    $("#categories").hide()
    that.showLoader("Jangala Market prépare votre board ! Merci de patienter.")
    @model.set 'title', 'Nouveau Board'
      # Save the board
    @model.save({},
      success: (model, response, options)->
        Nextdoorz.Cache.Boards.fetch success: ()->
          that.hideLoader()
          # Navigate to the newly created board
          Backbone.history.navigate "/boards/#{model.id}", trigger: true
          changeCreateBoardLinkLimit()

      , error: (model, xhr, options) ->
        # It raises an error if the user has reached the max of created boards
        errors = $.parseJSON(xhr.responseText).errors
        that.hideLoader()
        Nextdoorz.Cache.Boards.fetch success: ()->
          Backbone.history.navigate "/boards", trigger: true
          showAlert(errors["user"])
    )
    
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