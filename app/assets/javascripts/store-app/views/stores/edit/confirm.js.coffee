class Nextdoorz.Views.Confirm extends Backbone.View
  events:
    'click .confirm': "submitModel"
    'click .cancel': "hideModal"
  template: Nextdoorz.getTemplate('stores/edit/confirm')

  render: ()->
    $el = @$el
    @$el.html @template()
    @$el.modal()
    @$el.on 'hidden', ()->
      $el.remove()
    this
  submitModel: (e)->
    $el = @$el
    model = @model
    #$('.ajax-loader', $el).show()
    e.preventDefault()
    if model.get("variants") is undefined
      model.destroy {
        success: ()->
          @hideModal()
          @options.html_tag.remove()
        error: ()->
          #remove partial
          window.location.reload()
      }
    else
      model.get("variants").filter (variant) ->
        variant.set("stock", 0)
      model.save(
        success: ()->
          @hideModal()
          @options.html_tag.remove()
        error: ()->
          window.location.reload()
      )

  hideModal: ()->
    #$('.ajax-loader', $el).hide()
    @$el.modal('hide')

