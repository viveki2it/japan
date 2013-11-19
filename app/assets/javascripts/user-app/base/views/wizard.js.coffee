# Should require directory with step views
class Nextdoorz.Views.BaseWizard extends Nextdoorz.View
  initialViewName: undefined
  stepHolderSelector: '.u-steps'
  _getCachedView: (name)->
    @cache[name] ||= new Nextdoorz.Views[name](model: @model, wrapper: this)
  nextStep: ()->
    @_switchView @currentView.nextViewName
  prevStep: ()->
    @_switchView @currentView.prevViewName
  finishWizard: ()-> this
  afterViewChange: ()-> this
  _switchView: (name)->
    currentView = @currentView
    if currentView
      currentView.beforeSwitch()
    if name
      newView = @cache[name] ||= @_getCachedView(name)
      newView.beforeShow()
      newView.$el.hide()
      @$(@stepHolderSelector).append newView.$el
      $('.u-steps').animate('height': newView.$el.height())
      newView.$el.slideToggle()
      @currentView = newView
      if currentView
        return unless currentView.beforeHide()
        currentView.$el.hide ()->
          currentView.$el.detach()
      newView.afterSwitch()
    else
      currentView.beforeHide()
      @finishWizard()

    @afterViewChange()
  render: ()->
    # no call to Super!
    @$el.html @template()
    @_switchView @initialViewName
    this

