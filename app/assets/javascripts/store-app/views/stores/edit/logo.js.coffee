class Nextdoorz.Views.StoreEditLogo extends Backbone.View
  template: Nextdoorz.getTemplate('stores/edit/logo')
  modelBinder: new Backbone.ModelBinder()

  bindings:
    logo: '[name=logo]'
  events:
    {
    'click .save': "submitModel"
    }
  render: ()->
    $el = @$el
    $el.html @template model: @model
    #@$el.find('.picture-placeholder').html @pictureEdit.render().el
    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    this
  submitModel: ()->
    model = @model
    picture = @pictureEdit.model
    #model.set 'logo_base64', picture.attributes
    $el = @$el
    model.attributes['authenticity_token'] = Context.form_authenticity_token;
    model.save {},
      {
      data: model.attributes,
      files: $(":file", @$el),
      iframe: true,
      processData: false
      beforeSend: ()->
        $('.save', @$el).hide()
        $('.ajax-loader', @$el).show()
        $('.close', @$el).hide()
        $('.store_logo_file_upload').hide()
      complete: (response)->
        $('.save', @$el).show()
        $('.ajax-loader', @$el).hide()
        $('.close', @$el).show()
        $('.store_logo_file_upload').show()
        if $.parseJSON(response.responseText)['errors'] and $.parseJSON(response.responseText)['errors']['logo']
          errors = $.parseJSON(response.responseText)['errors']['logo']
          $(".popover").remove()
          $('.store_logo_file_upload').addClass('error')
          $('.store_logo_file_upload').popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: errors.join('<br/>')}).popover('show')
          $('.store_logo_file_upload').popover('show')
        else
          $el.modal 'hide'
          $('img.logo-store').attr 'src', $.parseJSON(response.responseText)['logo']['url']
      }
  initialize: ()->
    @pictureEdit = new Nextdoorz.Views.EditPicture {
    store_id: @model.get 'id'
    current_picture: @model.get 'logo'
    }