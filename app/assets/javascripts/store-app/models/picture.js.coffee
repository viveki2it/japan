class Nextdoorz.Models.Picture extends Backbone.Model
  urlRoot: ()->
    "/stores/#{@get 'store_id'}/pictures"
  typeName: 'picture'
  defaults:
    {
    image:
      {}
    }