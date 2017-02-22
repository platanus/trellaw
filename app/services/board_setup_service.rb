class BoardSetupService < PowerTypes::Service.new(:board)
  def setup(skip_webhook: false)
    ensure_ham_in_board
    setup_webhook unless skip_webhook
  end

  def cleanup
    # remove ham
    # remove webhook
  end

  private

  def ham_client
    @ham_client ||= TrelloUtils.summon_the_monkey
  end

  def user_client
    @user_client ||= TrelloUtils.load_user_client(@board.user)
  end

  def ensure_ham_in_board
    ham_tid = ham_client.get_member_tid
    if !user_client.board_member?(@board.board_tid, ham_tid)
      user_client.add_board_member(@board.board_tid, ham_tid)
    end
  end

  def setup_webhook
    webhook = ham_client.add_board_webhook(@board.board_tid, board_webhook_callback)
    @board.update_column(:webhook_tid, webhook.tid)
  end

  def board_webhook_callback
    Rails.application.routes.url_helpers.trello_callback_url(board_id: @board.id)
  end
end
