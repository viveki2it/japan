class Nextdoorz.Views.UpdateBoard extends Nextdoorz.View
  template: Nextdoorz.getTemplate('boards/update')
  child_view: undefined
  type_name: undefined
  el_class: undefined
  events:
    'click #save': 'do_save'
  do_save: ()->
    that = this
    $('#update_container').empty().hide()
    that.showLoader("Votre board va être mis à jour, merci de patienter.")
    @child_view.beforeSwitch()
    @child_view.beforeHide()
    @model.save {}, success: (model)->
      that.hideLoader()
      Nextdoorz.Routers.Boards.boards_index model.id
      showAlert('Votre filtre a été mis à jour', 500)
    false
  initialize: ()->
    child_view_name = @options.child_view_name
    @child_view = new Nextdoorz.Views[child_view_name] model: @model
    @child_view.beforeShow()
    @child_view.afterSwitch()
  render: ()->
    @$el.html @template()
    @$('#child_container').prepend @child_view.$el
    @$('#child_container').prepend('<h2>Modifier les ' + @type_name + ' du board</h2>')
    @$('#child_container').addClass(@el_class + ' l-dark')
    this