Nextdoorz.Initializers.General = ()->
  $('body').on 'focus', 'input, textarea', (e)->
    $item = $(e.currentTarget)
    $item.popover('hide')
  $('a.under-construction').popover
    title: "Version Bêta"
    content: "It is under active development and will be available soon"
    placement: "top"

  $('a.under-construction').on 'click', ()->
    false

