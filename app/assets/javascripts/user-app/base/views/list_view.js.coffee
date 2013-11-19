class Nextdoorz.Views.BaseList extends Nextdoorz.View
  # Default list view, each list (products / news, etc.)
  # inherits from this class.
  collection: undefined
  itemViewName: undefined # View used to render single model
  itemsListSelector: undefined # If left undefined, default value is @el itself

  # Append items of the list to the passed list tag. Default is this.el
  renderItems: ($itemsList) ->
    unless $itemsList
      $itemsList = @$el


    _.each(@children,
      (item_view)->
        $itemsList.append item_view.render().$el
    )

  initialize: ()->
    that = this

    ## Items & title
    @title = @options.title ||= ""
    @children = @collection.map (model)-> new Nextdoorz.Views[that.itemViewName](model: model, parent: that)

  render: ()->
    that = this

    if @itemsListSelector
      @$el.html @template(collection: @collection, title: @title)
      $itemsList = @$(@itemsListSelector)

    $itemsList.empty()

    @renderItems($itemsList)

    this
