class Nextdoorz.Views.DealListItem extends Nextdoorz.View
  tagName: 'article'
  template: Nextdoorz.getTemplate('deals/p_list_item')
  render: ()->
    @$el.html @template(deal: @model, board: @options.parent.options.board)
    this
