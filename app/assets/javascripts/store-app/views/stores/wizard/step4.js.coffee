class Nextdoorz.Views.ProfileWizardStep4 extends Backbone.View
  modelBinder: new Backbone.ModelBinder()

  bindings:
    {
    description: "[name=description]"
    }
  template: Nextdoorz.getTemplate('stores/wizard/step4')

  render: ()->
    $el = @$el
    @$el.html @template description: @model.get('desription')
    @modelBinder.bind @model, @$el, @bindings
    this

  initModel: () ->

  prepare: ()->
    @model
