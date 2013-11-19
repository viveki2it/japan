Nextdoorz.Views.PaginatedView = Backbone.View.extend {
events:
  {
  'click .pagination a': 'gotoPage'
  }
initialize: ()->
  _.bindAll(this, 'render')
  self = this
  @collection.fetch {
  success: () ->
    self.collection.pager()
  silent: true
  }
  @collection.bind('reset', this.render)

render: () ->
  self = this
  $('.paginator-items .row-fluid .span6', self.el).empty()
  count = 1
  @collection.each (item)->
    count += 1
    $('.paginator-items .row-fluid .span6', self.el).eq(count % 2).append Nextdoorz.getTemplate('news/list_item')({news: item.attributes})
gotoPage: (e)->
  e.preventDefault()
  page = $(e.target).text()
  @collection.goTo(page)



}