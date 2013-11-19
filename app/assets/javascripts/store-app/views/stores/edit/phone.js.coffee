class Nextdoorz.Views.StoreEditPhone extends Backbone.View

  modelBinder: new Backbone.ModelBinder()

  events:
    'click .save': "submitModel"

  bindings:
    phone: "[name=phone_number]"

  template: Nextdoorz.getTemplate('stores/edit/phone')

  render: ()->
    $el = @$el
    @$el.html @template()
    @$el.modal()
    @modelBinder.bind @model, @$el, @bindings
    @$el.on 'hidden', ()->
      $el.remove()
    this
  submitModel: (e)->
    e.preventDefault()
    @model.save {},
      {
      beforeSend: ()->
        $('.save', @$el).hide()
        $('.ajax-loader', @$el).show()
      error: ()->
        $('.save', @$el).show()
        $('.ajax-loader', @$el).hide()
      success: (response)->
        #       need to reload map
        location.reload()
      }
