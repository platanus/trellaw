class BoardLawsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user_linked

  def new
    @board_law = BoardLaw.new(
      board: current_user.boards.find(params[:board_id]),
      law: params[:law],
      list_tid: params[:list_tid]
    )

    @trello_list = trello_client.get_list(params[:list_tid]) if params.key? :list_tid
  end

  def create
    @board_law = BoardLaw.create create_params
    redirect_to board_path @board_law.board if @board_law.persisted?
  end

  private

  def trello_client
    @trello_client ||= TrelloUtils.load_user_client current_user
  end

  def create_params
    params.require(:board_law).permit(:board_id, :law, :list_tid).tap do |cp|
      cp[:board] = current_user.boards.find cp.delete :board_id
      cp[:settings] = YAML.safe_load(params[:board_law][:settings]).symbolize_keys
    end
  end
end
