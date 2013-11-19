Nextdoorz.Models.News= Backbone.Model.extend {
  urlRoot: '/news'
  url: ()->
    if @get 'id'
      url = "/news/#{@get 'id'}"
    else
      url = "/news"
    url + ".json"

typeName: 'News'
}