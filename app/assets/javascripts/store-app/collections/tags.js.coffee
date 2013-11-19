class Nextdoorz.Collections.Tags extends Backbone.Collection
  initialize: (options)->
    if options.store_id
      @url = "/stores/#{options.store_id}/tags"
    else
      @url = "/tags"
  model: Nextdoorz.Models.Tag
