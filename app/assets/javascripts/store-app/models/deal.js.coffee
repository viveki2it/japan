# Most of the features needed in Deals are already implemented in Product model, so we just inherit from it.
class Nextdoorz.Models.Deal extends Nextdoorz.Models.Product

  # Hold the id to sync with the server without the id field (See @url() method)
  copiedId: null

  urlRoot: '/deals'

  typeName: 'Deal'

  # nested attributes is already correctly defined in parent class
  filtered_attributes: [
    'id'
    'updated_at'
    'store'
    'stock'
    'trash'
    'discount_rate'
    'picture'
    'category'
    'tag'
  ]

  url: ()->
    if @copiedId?
      url = "/deals/#{@copiedId}"
    else
      url = "/deals"
    url += ".json"
    if @trash? and @trash
      url += "?trash"
    url

  toJSON: ->
    deal: _.clone @attributes
