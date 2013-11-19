class BaseRouter extends Nextdoorz.Router
  routes:
    '': 'home'
    '_=_': 'home'
    'products/:id':'single'
    
  home: ()->
    if Context.current_user || Context.boards
      Backbone.history.navigate "/boards", trigger: true
    else
      Backbone.history.navigate "/boards/new", trigger: true

  signup: ()->
    view = new Nextdoorz.Views.Signup
    @swap view
  
  single: () ->
    view = new Nextdoorz.Views.ShowSingleItem
    @swap view

Nextdoorz.Routers.Base = new BaseRouter()