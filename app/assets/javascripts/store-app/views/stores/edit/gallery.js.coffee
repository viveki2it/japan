class Nextdoorz.Views.StoreEditGallery extends Backbone.View

  template: Nextdoorz.getTemplate('stores/edit/gallery')
  events:
    'click .save': "submitModel"
  render: ()->
    $el = @$el
    $el.html @template
    @pictureEdit1 = new Nextdoorz.Views.EditPicture {
    store_id: @model.get 'id'
    el: @$el.find('#picture-placeholder1')
    }
    @pictureEdit2 = new Nextdoorz.Views.EditPicture {
    store_id: @model.get 'id'
    el: @$el.find('#picture-placeholder2')
    }
    @pictureEdit1.render()
    @pictureEdit2.render()
    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    this
  submitModel: ()->
    @model.set 'pictures', [
      @pictureEdit1.model.attributes
      @pictureEdit2.model.attributes
    ]
    @model.save {}, {
    beforeSend: ()->
      $('.save', @$el).hide()
      $('.ajax-loader', @$el).show()
    error: ()->
      $('.save', @$el).show()
      $('.ajax-loader', @$el).hide()
    success: ()->
      window.location.reload()
    }