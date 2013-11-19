Nextdoorz.Collections.Deals = Backbone.Collection.extend

  model: Nextdoorz.Models.Deal

  trash: false

  initialize: (options)->
    if options.store_id
      @url = "/stores/#{options.store_id}/deals"
    else
      @url = "/deals"
    @url+='.json'
    if options.trash? and options.trash
      @url += '?trash'
#    _.extend(this, Nextdoorz.mixins.Pagination)
#    this.perPage = 4
