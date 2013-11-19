class Nextdoorz.Views.Modal extends Backbone.View
  template: Nextdoorz.getTemplate('basic/modal')
  render: ()->
    $el = @$el
    $el.html @template(title: @options.title, url: @options.url)
    $el.modal()
    $el.on 'hidden', ()->
      $(".popover").remove()
      $el.remove()
    this