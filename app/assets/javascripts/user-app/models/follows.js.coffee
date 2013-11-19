class Nextdoorz.Models.Follows extends Nextdoorz.Model
  url: '/follows.json'

  createCollections: (attributes)->
    attributes.products ||= new Nextdoorz.Collections.Products()
    attributes.deals ||= new Nextdoorz.Collections.Deals()
    attributes.news ||= new Nextdoorz.Collections.News()
    attributes.stores ||= new Nextdoorz.Collections.Stores()
    attributes

  arraysToCollections: (attributes)->
    aProductsAttributes = attributes.products
    unless aProductsAttributes instanceof Nextdoorz.Collections.Products
      attributes.products = new Nextdoorz.Collections.Products aProductsAttributes

    aDealsAttributes = attributes.deals
    unless aDealsAttributes instanceof Nextdoorz.Collections.Deals
      attributes.deals = new Nextdoorz.Collections.Deals aDealsAttributes

    aNewsAttributes = attributes.news
    unless aNewsAttributes instanceof Nextdoorz.Collections.News
      attributes.news = new Nextdoorz.Collections.News aNewsAttributes
      
    aStoresAttributes = attributes.stores
    unless aNewsAttributes instanceof Nextdoorz.Collections.Stores
      attributes.stores = new Nextdoorz.Collections.Stores aStoresAttributes

    attributes
  
  filtered_fields: ['products', 'deals', 'news', 'paginated_deals', 
  'paginated_products', 'paginated_news']
  #initialize: ()->
  #  @on "change", this.fetchCollections, this
  #  super
  #
  #fetchCollections: ()->
