# -*- encoding : utf-8 -*-
class BoardsController < ApplicationController

  def index
    if user_signed_in?
      @boards = Board.where(user_id: current_user.id).all
      authorize! :index, Board
      
    elsif get_temporary_boards.any?
      @boards = get_temporary_boards
      
    else 
      redirect_to home_page_url
    end
  end

  # This is called when a user access a specific board.
  # When (and as) it's loaded by JSON It's associated to the boards/show.rabl view
  def show
    if Board.exists?(params[:id].to_i)
      @board  = Board.find_user_board(params[:id])
      @board.page = params[:page].to_i unless params[:page].blank?
  
      unless is_temporary?(@board)
        authorize! :show, @board
      end
    else
      render :json => { :errors => {:board => "Ce board n'est pas accessible"}}, :status => 422
    end
  end

  def create
    @board = Board.new prepare_params(params[:board])

    if @board.save
      # TODO: It would be great to purge all boards non-associated to a user
      # using clock-work. Or with a simple button in the admin part of the app.
      session["temporary_board_id"] = @board.id unless user_signed_in?
      render 'show'
    else
      render :json => { :errors => @board.errors }, :status => 422
    end
  end

  def update
    @board = Board.find params[:id]
    
    authorize! :update, @board unless is_temporary?(@board)
    
    if @board.update_attributes prepare_params(params[:board])
      render 'show'
    else
      render json: @board.errors
    end
  end

  def destroy
    @board = Board.find params[:id]
    authorize! :destroy, @board unless is_temporary?(@board)
    @board.destroy
    render json: {}
  end

  # Set a temporary board, this function is no longer used
  #def set_temporary
    # Create a board.
    
  #  @board = Board.create params[:board]
  #  @board.page = params[:page].to_i unless params[:page].blank?

    # Store the temporary board id in the session
  #  session["temporary_board_id"] = @board.id
  #  render 'show'
  #end

  #def get_temporary
    # Get_temporary_board is defined in the session helper
  #  @board = get_temporary_boards.first()
  #  render json: @board
  #end

  private

    def prepare_params(board_params)
      p = board_params.clone
      p.delete_if { |k, v| k.blank? }
      p[:user_id] = current_user.id if user_signed_in?
      p
    end

    def is_temporary?(board = @board)
      !get_temporary_boards.blank? && get_temporary_boards.include?(board)
    end    
end
