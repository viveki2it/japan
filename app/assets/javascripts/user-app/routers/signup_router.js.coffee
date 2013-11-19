class SignupRouter extends Nextdoorz.Router
  routes:
    'signup/board': 'board'
    'signup': 'signup'
    'signin': 'signin'

  board: ()->

    if Context.current_user
      Backbone.history.navigate "/boards", trigger: true
    else

      board = Context.boards

      if board
        Backbone.history.navigate "/boards", trigger: true
      else
        Backbone.history.navigate "/boards/new", trigger: true

  signup: ()->
    if Context.current_user
      Backbone.history.navigate "/boards", trigger: true
    else
      view = new Nextdoorz.Views.Signup
      @swap view

  signin: ()->
    if Context.current_user
      Backbone.history.navigate "/boards", trigger: true
    else
      view = new Nextdoorz.Views.Signin
      @swap view


Nextdoorz.Routers.Signup = new SignupRouter()