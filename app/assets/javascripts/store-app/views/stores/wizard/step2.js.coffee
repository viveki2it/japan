class Nextdoorz.Views.ProfileWizardStep2 extends Backbone.View

  modelBinder: new Backbone.ModelBinder()

  bindings:
    {
    'address.street_number': '[name=street_number]'
    'address.street_name': '[name=street_name]'
    'address.postal_code': '[name=postal_code]'
    # 'address.city': '[name=city]'
    'phone': '[name=phone_number]'
    }
  template: Nextdoorz.getTemplate('stores/wizard/step2')
  render: ()->
    $el = @$el
    @$el.html @template address: @model.attributes.address
    @modelBinder.bind @model, @$el, @bindings
    unless @model.attributes.address #- fix for display errors of address for new store
      @model.attributes.address = {}
      @model.attributes.address.street_number = ' '
    this

  prepare: ()->
    @model
