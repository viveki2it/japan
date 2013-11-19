class Nextdoorz.Views.WizardEditGallery extends Backbone.View
  template: Nextdoorz.getTemplate('stores/edit/gallery')
  render: ()->
    $el = @$el
    $el.html @template
    @$el.find('.picture-placeholder').html @pictureEdit.render().el
    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    this
  initialize: ()->
    @pictureEdit = new Nextdoorz.Views.EditPicture