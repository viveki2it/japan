#= require_self
#= require_tree ./base
#= require_directory ./modules
#= require_directory ./models
#= require_directory ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_directory ./routers
window.Nextdoorz =
  type: 'user'
  Models:
    {}
  Collections:
    {}
  Views:
    {}
  Cache:
    byCid:
      {}
  Modules:
    {}
  Routers:
    {}
  ViewHelpers:
    idFromString: (sId)->
      parseInt sId.slice(sId.lastIndexOf('_') + 1, sId.length), 10
    link_to: (text, address, options)->
      "<a href='/user#{address}'>#{text}</a> "

  # Nextdoorz init function. This is the first one to get called
  init: ()->
    # Attach view helpers to global object
    _.each @ViewHelpers, (helper, name)-> window[name] = helper
    @Cache.Modules = _.map @Modules, (Module)-> (new Module()).initialize()

    # Start application router
    Backbone.history.start pushState: true, root: '/user/'

  getTemplate: (path)->
    JST['user_app/templates/' + path]


$(document).on 'ready', ()->
  if document.location.pathname.indexOf('/user') == 0 && document.location.pathname.indexOf('/users') !=0
    Nextdoorz.init()