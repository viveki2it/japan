class Nextdoorz.Router extends Support.SwappingRouter
  initialize: ()->
    @el = $('#container')
  swap: (newView)->
    @currentView = Nextdoorz.Cache.ContentView
    currentView = @currentView

    @currentView = newView.render()
    newView.$el.hide()
    @el.append newView.$el


    if currentView
      currentView.$el.slideToggle ()->

        currentView.$el.detach()
        if _.isFunction(currentView?.leave)

          currentView.leave()

    newView.$el.slideToggle()

    Nextdoorz.Cache.ContentView = @currentView

