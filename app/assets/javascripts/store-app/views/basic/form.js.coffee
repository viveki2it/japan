class Nextdoorz.Views.AbstractForm extends Backbone.View
  bindings: undefined
  pictureEdit: undefined

  events:
    'click .save': "submitModel"
    'click button.clear': "clearForm"
    'click  #tagcat-block ul a': (e)->
      e.preventDefault()
      $(".popover").remove()
      $li = $(e.currentTarget).parent()
      @setCurrentTagCat $li.attr('group_id'), true
    'click #tag-block ul a': (e)->
      e.preventDefault()
      $(".popover").remove()
      $li = $(e.currentTarget).parent()
      @model.set 'tag_id', $li.attr('tag_id')

  setCurrentTagCat: (group_id, filter = false)->
    return unless group_id
    $item = @$("#tagcats ul li[group_id=#{group_id}]")
    @filterTagsDropdown(group_id) if filter
    name = $item.find('a').html()
    @$('#tagcat-input .current').html name
    @$('#tags').removeClass('dnone').addClass('dib')

  setCurrentTag: (tag_id, filter = false)->
    return unless tag_id
    $item = @$("#tags ul.dropdown-menu>li[tag_id=#{tag_id}]")
    tag_name = $item.attr('tag_name')
    group_id = $item.attr('group_id')
    @setCurrentTagCat group_id, filter
    @$('#tag-input span.current').html tag_name.capitalize()

  filterTagsDropdown: (group_id)->
    return unless group_id
    view = this
    @$("#tags ul.dropdown-menu>li:not([group_id=#{group_id}])").hide()
    $first = @$("#tags ul.dropdown-menu>li[group_id=#{group_id}]").show().first()
    #@model.set 'tag_id', parseInt($first.attr('tag_id'), 10)
    @$('#tag-input span.current').html "Tag"

  submitModel: ()->
    model = @model
    picture = @pictureEdit.model
    picture_method = @pictureEdit.method
    picture_has_file = @pictureEdit.hasFile
    $el = @$el
    current_view = this
    unless picture.attributes.image_base64 or (picture_method == 'iframe' and picture_has_file) or model.get 'id'
      $('[name=image]').addClass('error').popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: 'Please attach picture'}).popover('show')
    else
      #TODO check why there is a picture attribute causing a new problem here
      model.unset('picture')
      model.save {},
        {
        beforeSend: ()->
          $('.save', $el).hide()
          $('.ajax-loader', $el).show()
          $('.close', $el).hide()
        success: ()->
          if (picture_method == 'data' and picture.attributes.image_filename) or (picture_method == 'iframe' and picture_has_file)
            picture.set 'decorated_type', model.typeName
            picture.set 'decorated_id', model.get('id')
  
            if picture_method == 'data'
              picture.save {},
                {
                success: ()->
                  window.location.reload()
                }
            else  # 'iframe' method - compatibility mode for IE and Opera
              picture.attributes['authenticity_token'] = Context.form_authenticity_token;
              picture.save {},
                {
                data: picture.attributes,
                files: $(":file", picture.$el),
                iframe: true,
                processData: false
                complete: (response)->
                  window.location.reload()
                }
          else
            window.location.reload()
        error: (e, response)->
          $('.save', @$el).show()
          $('.ajax-loader', @$el).hide()
          $('.close', @$el).show()
          errors = $.parseJSON(response.responseText)
          $("input", $(e.target)).data('popover', null).removeClass('error')
          $(".popover").remove()
          unless picture.attributes.image_base64 or (picture_method == 'iframe' and picture_has_file) or model.get 'id'
            $('.modal [name=image]').addClass('error').popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: 'Veuillez inclure une image'}).popover('show')
  
          $.each errors, (field, error)->
            if field == 'tag_id'
              if $('.modal #tags').is(':visible')
                target = $('.modal #tags')
              else
                target = $('.modal #tagcats')
            else
              target = $(current_view.bindings[field], $el)
            target.addClass('error').popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: error.join('<br/>')}).popover('show')
  
        }

  clearForm: ()->
    @model.clear()
    @pictureEdit.model.clear()

  cleanUpContext: ()->
    @model = undefined
    @$el.html('')

  initialize: ()->
    @modelBinder = new Backbone.ModelBinder()
    if !@options.model
      @cleanUpContext()
    @initModel()
    @tags = @options.tags if @options.tags
    store_id = Context.current_user.store_id
    @model.set 'store_id', store_id
    picture = new Nextdoorz.Models.Picture
      store_id: store_id
      decorated_type: @model.typeName
      decorated_id: @model.get('id')
    @pictureEdit = new Nextdoorz.Views.EditPicture model: picture

  render: ()->
    if @$el.html() == ''
      @$el.html @template model: @model, tags: @tags
      @$el.find('.picture-placeholder').html @pictureEdit.render().el
      @$el.find('[data-datetimepicker=true]').datepicker(dateFormat: 'yy-mm-dd')
      @$('[name=tag_id]').hide()
      @$el.modal()
      @$el.on 'hidden', ()->
        $(".popover").remove()
      @modelBinder.bind @model, @el, @bindings
      view = this
      if @model.get('tag_id')
        view.setCurrentTag @model.get('tag_id'), true
      @model.on 'change:tag_id', (model, value)->
        view.setCurrentTag value
    else
      @$el.modal 'show'
    this
