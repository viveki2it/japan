class Nextdoorz.Views._RenameBoard extends Nextdoorz.View
  template: Nextdoorz.getTemplate('boards/p_rename')
  tagName: 'span'
  events:
    'keydown input[name=title]': 'enter_pressed'
    'click .edit-board-name-button': 'click_edit_button'
    'click': 'stop_propagation'

  # Not sure if this function is usefull?
  stop_propagation: (e)->
    e.stopPropagation()
  
  # When a click on the edit buttons happens
  click_edit_button: (e)->
    @_saveAndFinish()
    
  # When a key is pressed
  enter_pressed: (e)->
    if @$('input').attr('size') <= 13
      @$('input').attr('size', @$('input').val().length)
    else
      false

    if e.keyCode == 13
      @_saveAndFinish()

    true

  # Save the model (the board with the new name) and call the finishCallback
  _saveAndFinish: ()->
    that = this
    input = @$('input')
    @$(".btn.edit-board-name-button").hide()
    @$(".ajax-loader").show()
    input.attr("disabled", true)
    input.css("border-right", "1px solid #CCCCCC")
    that.model.save 'title', @$('input[name=title]').val(), success: ()->
      input.blur()
      that.finishCallback()


  finishCallback: undefined

  initialize: ()->
    super
    @finishCallback = @options['callback'] || ()->true

  render: ()->
    @$el.html @template(title: @model.get('title'))
    input = @$('input')
    view = this
    
    # Get the size of the input 
    input.attr('size', @$('input').val().length)
    input.attr('autofocus', true)
    input.attr("maxlength", 13)
    this