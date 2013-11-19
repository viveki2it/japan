class Nextdoorz.Views.StoreEditDescription extends Backbone.View

  modelBinder: new Backbone.ModelBinder()

  events:
    'click .save': "submitModel"

  bindings:
    description: "[name=description]"

  template: Nextdoorz.getTemplate('stores/edit/description')

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
