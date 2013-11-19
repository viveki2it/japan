class Nextdoorz.Modules.LinkHandler extends Nextdoorz.Module
  name: 'LinkHandler'
  initialize: ()->
    $('body').on 'click', "a:not([rel*=external])", @linkClickHandler
    this
  linkClickHandler: (event)->
    url = $(event.target).attr('href')
    if url and url.length
      if url[0] == '/'
        url = url.slice 1, url.length
      prefix = url.slice 0, (if url.length < 5 then url.length else 5)
      if (prefix == 'user/' || prefix == 'user')
        url = url.slice 5, url.length
        Backbone.history.navigate url, true
        return false
    this
