class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_linked

  def index
    @boards = current_user.boards.all
    @trello_boards = trello_client.get_own_boards
  end

  def new
    @trello_board = trello_client.get_board(params[:board_tid])
    @board = Board.new board_tid: params[:board_tid]
  end

  def create
    Board.transaction do
      @board = current_user.boards.create! board_tid: params[:board][:board_tid]
      BoardSetupService.new(board: @board).setup(skip_webhook: !Rails.env.production?)
    end

    # TODO: flash notice?

    redirect_to board_path @board
  end

  def show
    @board = current_user.boards.find params[:id]
    @board_laws = @board.board_laws.all
    @trello_board = trello_client.get_board(@board.board_tid)
    @trello_lists = trello_client.get_lists(@board.board_tid)
    @all_laws = LawUtils.active_laws
  end

  def update_violations
    @board = current_user.boards.find params[:id]

    UpdateViolations.for board: @board

    redirect_to board_path @board
  end

  private

  def trello_client
    @trello_client ||= TrelloUtils.load_user_client current_user
  end
end
