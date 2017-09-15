class Api::V1::BoardLawsController < Api::V1::BaseController
  def create
    respond_with board.board_laws.create(create_params)
  end

  def show
    respond_with board_law
  end

  private

  def create_params
    params.require(:board_law).permit(:law, :list_tid, settings: {})
  end

  def board
    @board ||= Board.find(params[:board_id])
  end

  def board_law
    @board_law ||= BoardLaw.find(params[:id])
  end
end
