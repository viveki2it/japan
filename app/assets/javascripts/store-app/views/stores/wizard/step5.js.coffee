class Nextdoorz.Views.ProfileWizardStep5 extends Backbone.View
  template: Nextdoorz.getTemplate('stores/wizard/step5')
  modelBinder: new Backbone.ModelBinder()
  isSkipable: true
  files:true

  events:
    "change .store_logo_file_upload": "isImgPresent"

  bindings:
    logo: '.store_logo_file_upload'

  render: ()->
    $el = @$el
    $el.html @template model: @model
    #@$el.find('.picture-placeholder').html @pictureEdit.render().el
    this

  prepare: ()->
    model = @model
#    picture = @pictureEdit.model
#    model.set 'logo_base64', picture.attributes
    model

  isImgPresent: ->
    if !$('.store_logo_file_upload').val()
      $('.save').html("Passer")
    else
      $('.save').html("Valider")


#  initialize: ()->
#    @pictureEdit = new Nextdoorz.Views.EditPicture store_id: @model.get 'id'
