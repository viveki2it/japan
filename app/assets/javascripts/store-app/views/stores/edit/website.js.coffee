class Nextdoorz.Views.StoreEditWebsite extends Backbone.View

  modelBinder: new Backbone.ModelBinder()
  events:
    {
    'click .save': "submitModel"
    }
  bindings:
    website_url: "[name=website_url]"
    
  template: Nextdoorz.getTemplate('stores/edit/website')
  render: ()->
    $el = @$el
    @$el.html @template()
    @$el.modal()
    # Bind model attributes with form fields
    @modelBinder.bind @model, @$el, @bindings
    @$el.on 'hidden', ()->
      $el.remove()
    this
  # TODO: Submit model, should be shared accross store edit views...
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
