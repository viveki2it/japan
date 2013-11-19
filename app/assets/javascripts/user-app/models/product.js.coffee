class Nextdoorz.Models.Product extends Nextdoorz.Model
  urlRoot: '/products'
  paramName: 'product'

  get_currency_price: () ->
    @get("price").formatMoney()
