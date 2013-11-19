class Nextdoorz.Views.BaseWizardStep extends Nextdoorz.View
  nextViewName: undefined
  prevViewName: undefined
  initialize: ()->
    @modelBinder = new Backbone.ModelBinder() if @modelBindings
    @wrapper = @options.wrapper
  render: ()->
    @$el.html @template(model: @model)
    @modelBinder?.bind @model, @el, @modelBindings
    this