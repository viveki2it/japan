class Nextdoorz.Views.ProductListItem extends Nextdoorz.View
  tagName: 'article'
  template: Nextdoorz.getTemplate('products/p_list_item')
  render: ()->
    @$el.html @template(product: @model, board: @options.parent.options.board)
    this
