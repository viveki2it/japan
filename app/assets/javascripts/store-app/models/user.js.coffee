class Nextdoorz.Models.User extends Backbone.Model
  url: ()->
    "/users/#{@get 'id'}"
