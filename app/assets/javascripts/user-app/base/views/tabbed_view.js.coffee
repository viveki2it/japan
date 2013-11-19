# Needs to require file with item view
# Just call @changeActiveTab on whatever event you want.
class Nextdoorz.Views.BaseTabbedView extends Nextdoorz.View
  itemViewName: undefined # View used to render single model
  collection: undefined # For each item we create a tab
  tabContainerSelector: '#tab_container'
  currentView: undefined
  afterTabChange: ()-> true
  _getCachedView: (model)->
    @cache[model.cid] ||= new Nextdoorz.Views[@itemViewName](model: model, wrapper: this)

  # Called when user is changing tabs for his boards
  changeActiveTab: (id)->
    model = @collection.get id
    currentView = @currentView
    newView = @_getCachedView model

    # Call the beforeShow callback

    return unless newView.beforeShow()

    if currentView
      return unless currentView.beforeHide()
      currentView.$el.detach()
      #currentView.$el.slideToggle ()->
      #  currentView.$el.detach()

    newView.$el.hide()
    @$(@tabContainerSelector).append newView.$el
    newView.$el.show()
    #newView.$el.slideToggle()
    @currentView = newView

    @currentId = id

    # Call the callback
    @afterTabChange()
