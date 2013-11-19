class Nextdoorz.Views.ProfileWizard extends Backbone.View
  current_step: undefined
  steps: 5
  step_views: []
  events:
    'click .save': "submitModel",
    
  template: Nextdoorz.getTemplate('stores/wizard/main')
  
  initialize: ()->
    @current_step = @model.get 'wizard_step'
    #    @user = new Nextdoorz.Models.User(id: Context.current_user.id)
    #    @user.fetch()

    for step in [@current_step..@steps]
      @step_views.push new Nextdoorz.Views["ProfileWizardStep#{step}"] model: @model

    @current_step_view = @step_views.shift()

  render: ()->
    $el = @$el
    $el.html @template step: @current_step, steps: @steps
    $step_placeholder = @$el.find('.step-placeholder')
    $step_placeholder.html @current_step_view.render().el if @el
    $step_placeholder.addClass "step#{@current_step}"
    $el.modal()
    $el.on 'hidden', ()->
      $el.remove()
    if @current_step_view.isSkipable?
      $('.save').html("Passer")
    this

  nextStep: ()->
    ++@current_step
    @model.set('wizard_step', if @current_step <= @steps then @current_step else 0)
    view_object = @
    @model.save {},{
    beforeSend:()->
      $('.save',view_object.$el).hide()
      $('.ajax-loader',view_object.$el).show()
    complete:()->
      $('.save',view_object.$el).show()
      $('.ajax-loader',view_object.$el).hide()
    success: (e, response)=>
      if view_object.current_step_view = view_object.step_views.shift()
        view_object.render()
        @updateWizardStatus()
      else
        window.location.reload()
        view_object.$el.modal 'hide'
    }


  submitModel: ()->
    $wizard = @
    model = @current_step_view.prepare()
    current_step_view = @current_step_view

    if current_step_view.files
      model.attributes['authenticity_token'] = Context.form_authenticity_token;
      model.save {},
        {
        data: model.attributes,
        files: $(":file", @$el),
        iframe: true,
        processData: false
        beforeSend:()->
          $('.save',@$el).hide()
          $('.ajax-loader',@$el).show()
          $('.store_logo_file_upload').hide()
        complete:(response) =>
          $('.save',@$el).show()
          $('.ajax-loader',@$el).hide()
          $('.store_logo_file_upload').show()
          if $.parseJSON(response.responseText)['errors']
            errors = $.parseJSON(response.responseText)['errors']
            #        $("input", $(e.target)).data('popover', null).removeClass('error')
            $(".popover").remove()
            $.each errors, (field, error)->
              $(current_step_view.bindings[field]).addClass('error')
              $(current_step_view.bindings[field]).popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: error.join('<br/>')}).popover('show')
              $(current_step_view.bindings[field]).popover('show')
          else
            $("input").data('popover', null).removeClass('error')
            $(".popover").remove()
            $wizard.nextStep()
        }

    else
      if current_step_view.hasValidator and !current_step_view.isValid()
        return
      model.save {},
        {
        beforeSend:()->
          $('.save',@$el).hide()
          $('.ajax-loader',@$el).show()
        complete:()->
          $('.save',@$el).show()
          $('.ajax-loader',@$el).hide()
        success: (e, response)=>
          $("input", $(e.target)).data('popover', null).removeClass('error')
          $(".popover").remove()
          $wizard.nextStep()

        error: (e, response)->
          errors = $.parseJSON(response.responseText)['errors']

          $("input", $(e.target)).data('popover', null).removeClass('error')
          $(".popover").remove()
          $.each errors, (field, error)->
            $(current_step_view.bindings[field]).addClass('error')
            $(current_step_view.bindings[field]).popover({ live: true, placement: 'top', trigger: 'manual', title: 'Erreur', content: error.join('<br/>')}).popover('show')
            $(current_step_view.bindings[field]).popover('show')
        }
#
  updateWizardStatus: ->
    for step in [1 .. @steps]
      if @current_step == step
        $("#bread-step" + step).addClass("is-current")
      else if @current_step > step
        $("#bread-step" + step).removeClass("is-current")
        $("#bread-step" + step).addClass("is-valid")
