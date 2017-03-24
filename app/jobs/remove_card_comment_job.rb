class RemoveCardCommentJob < ApplicationJob
  queue_as :default

  def perform(_violation)
    trello_client.edit_card_comment(_violation.comment_tid, '...')
    _violation.update_column(:comment_tid, nil)
  end

  private

  def trello_client
    @trello_client ||= TrelloUtils.summon_the_monkey
  end
end
