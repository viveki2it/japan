class Nextdoorz.Views.NewsListItem extends Nextdoorz.View
  tagName: 'article'
  template: Nextdoorz.getTemplate('news/p_list_item')
  render: ()->
    @$el.html @template(news: @model, board: @options.parent.options.board)
    this
