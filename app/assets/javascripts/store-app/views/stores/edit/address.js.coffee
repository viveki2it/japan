class Nextdoorz.Views.StoreEditAddress extends Backbone.View

  modelBinder: new Backbone.ModelBinder()
  events:
    {
    'click .save': "submitModel"
    }
  bindings:
    {
    'address.street_number': '[name=street_number]'
    'address.street_name': '[name=street_name]'
    'address.postal_code': '[name=postal_code]'
    }
  template: Nextdoorz.getTemplate('stores/edit/address')
  render: ()->
    $el = @$el
    @$el.html @template address: @model.attributes.address
    @$el.modal()
    @modelBinder.bind @model, @$el, @bindings
    @$el.on 'hidden', ()->
      $el.remove()

    unless @model.attributes.address #- fix for display errors of address for new store
      @model.attributes.address = {}
      @model.attributes.address.street_number = ' '
    this
  submitModel: (e)->
    e.preventDefault()
    current_view = this
    @model.save {},
      {
      beforeSend: ()->
        $('.save', @$el).hide()
        $('.ajax-loader', @$el).show()
      error: (e, response)->
        $('.save', @$el).show()
        $('.ajax-loader', @$el).hide()
        errors = $.parseJSON(response.responseText)
        $("input", $(e.target)).data('popover', null).removeClass('error')
        $(".popover").remove()
        $.each errors, (field, error)->
          $(current_view.bindings[field]).addClass('error')
          $(current_view.bindings[field]).popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: error.join('<br/>')}).popover('show')
          $(current_view.bindings[field]).popover('show')
      success: (response)->
        #       need to reload map
        location.reload()
      }
