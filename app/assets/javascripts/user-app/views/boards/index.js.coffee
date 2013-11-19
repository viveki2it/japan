class Nextdoorz.Views.BoardsIndex extends Nextdoorz.Views.BaseTabbedView
  template: Nextdoorz.getTemplate('boards/index')
  itemViewName: 'ShowBoard'

  events:
    'click .board-link': 'change_board'
    'click .board-link.active': 'rename_board'
    'click .board-link.active>.i-close': 'remove_board'

  remove_board: (e)->
    $link = $(e.currentTarget).parent()
    id = idFromString $link.attr('id')
    board = @collection.get id
    boards_number = @collection.length
    board.destroy success: ()->
      #unless Context.current_user
      #  $('#btn-user-connect.signin-mode').hide()
      #  $('#btn-user-connect.signup-mode').show()
      Backbone.history.navigate '/boards', true
      changeCreateBoardLinkLimit((boards_number - 1))
      
    false

  rename_board: (e)->
    view = this

    # We block user navigation between his boards, until he has finished editing the name of the board
    view.is_editing = true


    id = idFromString $(e.currentTarget).attr('id')
    $oldNode = $(e.currentTarget)
    $li = $oldNode.parent()

    renameView = new Nextdoorz.Views._RenameBoard(
      oldNode: $oldNode,
      model: @collection.get(id),
      # Listen to the finish callback
      callback: ()->
        # When the finish callback of the "rename board view" is called
        # Replace the input by the old Node and replace the old name by the new one
        new_name = $li.find("input").val()
        $li.empty()
        $oldNode.find("span").html(new_name)
        $li.append $oldNode
        # Allow user to navigate again between his boards
        view.is_editing = false
    )


    $oldNode.detach()
    $li.append renameView.render().$el


  change_board: (e)->
    if this.is_editing
      e.preventDefault()
    else
      id = idFromString $(e.currentTarget).attr('id')
      unless id == @currentView.model.id
        $(window).off("scroll")
        @changeActiveTab id
    false

  _setActiveLink: (model)->
    @$('.tabs a.active').removeClass 'active'
    @$(model.getHtmlIdSelector()).addClass('active help-step1 help-step2')

  afterTabChange: ()->

    @_setActiveLink @currentView.model

  initialize: ()->
    super
    @currentId = @options.id ||= @collection.first().id
    this.is_editing = false
    

  leave: ()->
    $(window).off("scroll")

  # Called when rendering a board
  render: ()->

    @currentView = undefined
    

    @$el.html @template(boards: @collection, help_link: true)

    @changeActiveTab @currentId

    this