class Nextdoorz.Views.ShowFollows extends Nextdoorz.View
  template: Nextdoorz.getTemplate('follows/show')
  _prepareItemListViews: ()->
    @cache['products'] = new Nextdoorz.Views.ProductsList(collection: @model.get('products'), title: "Les produits", board: @model)
    @cache['deals'] = new Nextdoorz.Views.DealsList(collection: @model.get('deals'), title: "Les promotions", board: @model)
    @cache['news'] = new Nextdoorz.Views.NewsList(collection: @model.get('news'), title: "Les actualités", board: @model)
  render: ()->
    @$el.html @template(board: @model)
    $itemsList = @$('#items_list').empty()

    @_prepareItemListViews()

    _.each @cache, (view)->
      $itemsList.append view.render().$el

    @$('a.follows').addClass('active')

    this
