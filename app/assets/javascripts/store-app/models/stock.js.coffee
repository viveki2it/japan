class Nextdoorz.Models.Stock extends Backbone.Model
  urlRoot: ->
    "/stores/#{@get 'store_id'}/products.json"
  typeName: 'stock'
