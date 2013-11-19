Nextdoorz.Collections.News = Backbone.Collection.extend({
  model: Nextdoorz.Models.News
  initialize: (options)->
    if options.store_id
      @url = "/stores/#{options.store_id}/news"
    else
      @url = "/news"
    @url+='.json'
#    _.extend(this, Nextdoorz.mixins.Pagination)
#    this.perPage = 4
})
