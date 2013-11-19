class Nextdoorz.Views.ShowJangalist extends Nextdoorz.View
  template: Nextdoorz.getTemplate('jangalist/show')
  _prepareItemListViews: ()->
    @cache['products'] = new Nextdoorz.Views.ProductsList(collection: @model.get('products'), title: "Mes produits", board: @model)
    @cache['deals'] = new Nextdoorz.Views.DealsList(collection: @model.get('deals'), title: "Mes promotions", board: @model)
  render: ()->
    model = @model
    @$el.html @template(list: @model)
    $itemsList = @$('#items_list').empty()

    @_prepareItemListViews()
    _.each @cache, (view)->
      $el = view.render().$el
      $el.addClass 'double'
      $itemsList.append $el

    @$('a.jangalist').addClass('active')
    this