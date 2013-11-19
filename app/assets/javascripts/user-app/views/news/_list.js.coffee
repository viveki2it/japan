class Nextdoorz.Views.NewsList extends Nextdoorz.Views.BaseList
  tagName: 'section'
  className: 'articles-col col news'
  # Don't forget to look at templates/news/p_list.hamlc to see the hamlc !
  template: Nextdoorz.getTemplate('news/p_list')
  itemViewName: 'NewsListItem'
  itemsListSelector: '#news_list'
  board: undefined
