class Nextdoorz.Views.DealsList extends Nextdoorz.Views.BaseList
  tagName: 'section'
  className: 'articles-col col deals'
  template: Nextdoorz.getTemplate('deals/p_list')
  itemViewName: 'DealListItem'
  itemsListSelector: '#deals_list'
  board: undefined
