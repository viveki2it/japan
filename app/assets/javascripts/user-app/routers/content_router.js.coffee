class ContentRouter extends Nextdoorz.Router
  routes:
    'jangalist': 'jangalist'
    'follows': 'follows'

  jangalist: ()->
    if Context.current_user
      that = this
      model = Nextdoorz.Cache.Jangalist ||= new Nextdoorz.Models.Jangalist()
      view = new Nextdoorz.Views.ShowJangalist(model: model)
      model.fetch success: ()->
        that.swap(view)
    else
      Backbone.history.navigate "/signup", trigger: true

  follows: ()->
    if Context.current_user
      that = this
      # TODO: wire up with real data
      model = new Nextdoorz.Models.Follows()
      view = new Nextdoorz.Views.ShowFollows model: model
      model.fetch success: ()->
        
        that.swap view
    else
      Backbone.history.navigate "/signup", trigger: true
  
Nextdoorz.Routers.Content = new ContentRouter()
