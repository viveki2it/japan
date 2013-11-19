class Nextdoorz.Views.ShowPicture extends Backbone.View
  template: Nextdoorz.getTemplate('pictures/show')
  bindHandlers: ()->
    model = @model
    @$el.on 'click', 'a', ()->
      model.fetch success: (model, response) ->
        lightbox = new Nextdoorz.Views.LightboxPicture model: model
        lightbox.render()
      false
  initialize: ()->
    @model ||= new Nextdoorz.Models.Picture
    if @$el.html() != ''
      @model.set 'id', @$el.attr('data-model-id')
      @bindHandlers()
  render: ()->
    @el = @template picture: @model
    @bindHandlers()
    this



