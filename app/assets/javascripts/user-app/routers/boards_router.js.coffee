class BoardsRouter extends Nextdoorz.Router
  routes:
    'boards/new': 'new_board'
    'boards': 'boards_index'
    'boards/:id': 'boards_index'
  boards_index: (id)->
    boards = Nextdoorz.Cache.Boards || Context.temporary_board || Context.boards
    unless boards.length
      Backbone.history.navigate '/boards/new', trigger: true
    else
      view = new Nextdoorz.Views.BoardsIndex collection: boards, id: id
      @swap view

  new_board: ()->
    board = new Nextdoorz.Models.Board()
    board.is_new = true
    view = new Nextdoorz.Views.NewBoard model: board
    @swap view

Nextdoorz.Routers.Boards = new BoardsRouter()