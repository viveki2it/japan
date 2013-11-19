class Nextdoorz.Models.Jangalist extends Nextdoorz.Model
  urlRoot: '/jangalist'
  arraysToCollections: (attributes)->
    aProductsAttributes = attributes.products
    attributes.products = new Nextdoorz.Collections.Products aProductsAttributes

    aDealsAttributes = attributes.deals
    attributes.deals = new Nextdoorz.Collections.Deals aDealsAttributes

    aStoresAttributes = attributes.stores
    attributes.stores = new Nextdoorz.Collections.Stores aStoresAttributes

    attributes
  filtered_fields: ['products', 'deals', 'news', 'paginated_deals', 
  'paginated_products', 'paginated_news']