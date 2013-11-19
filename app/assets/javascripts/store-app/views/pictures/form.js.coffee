class Nextdoorz.Views.EditPicture extends Backbone.View
  template: Nextdoorz.getTemplate('pictures/form')
  bindings:
    {
    image_type: '[name=image_type]'
    image_filename: '[name=image_filename]'
    image_base64: '[name=image_base64]'
    }
  events:
    {
    'change input[name=image]': "updateImage"
    'change input[name=image_base64]': "renderPreview"
    }
  renderPreview: ()->
    $preview = $('.upload-preview img', @el)
    $t = @$ 'input[name=image_base64]'
    $preview.attr 'src', $t.val()
  updateImage: (event)->
    $el = @$el
    input = event.target
    file = input.files?[0]
    @hasFile = true
    unless file
      if $(input).val()
        # compatibility mode for IE and Opera
        @method = 'iframe'
      else
        @hasFile = false
      return
    reader = new FileReader()
    model = @model
    reader.onload = (e) ->
      $el.find('[name=image_base64]').attr 'value', e.target.result
      $el.find('[name=image_filename]').attr 'value', file.name
      $el.find('[name=image_type]').attr 'value', file.type
      model.set 'image_base64', e.target.result
      model.set 'image_filename', file.name
      model.set 'image_type', file.type
      # need to trigger it manually so model gets updated
      $el.find('.image_data').change()
    reader.readAsDataURL(file)
  initialize: ()->
    @current_picture = @options.current_picture if @options.current_picture
    @model ||= new Nextdoorz.Models.Picture store_id: @options.store_id
    view = this
    @modelBinder = new Backbone.ModelBinder()
    @method = 'data'
    @hasFile = false

  render: ()->
    @$el.html @template current_picture: @current_picture
    @modelBinder.bind @model, @el, @bindings
    model = @model
    if @model.get('decorated_id')
      decorated = new Nextdoorz.Models[@model.get('decorated_type')](id: @model.get 'decorated_id')
      decorated.fetch success: (m)->
        @$('.upload-preview img').attr 'src', m.get('picture').middle
        model.set 'id', m.get('picture').id
    this