class Nextdoorz.Views.LightboxPicture extends Backbone.View
  template: Nextdoorz.getTemplate('pictures/lightbox')
  render: ()->
    @el = @template picture: @model
    $el = $(@el)
    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    this
