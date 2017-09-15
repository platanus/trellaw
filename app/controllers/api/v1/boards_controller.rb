class Api::V1::BoardsController < Api::V1::BaseController
  def show
    respond_with board
  end

  private

  def board
    @board ||= Board.find(params[:id])
  end
end
