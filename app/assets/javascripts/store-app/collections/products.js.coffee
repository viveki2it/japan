Nextdoorz.Collections.Products = Backbone.Collection.extend

  model: Nextdoorz.Models.Product

  trash: false

  initialize: (options)->

    if options.store_id
      @url = "/stores/#{options.store_id}/products"
    else
      @url = "/products"
    @url += '.json'
    if options.trash? and options.trash
      @url += '?trash'
#    _.extend(this, Nextdoorz.mixins.Pagination)
#    this.perPage = 4
