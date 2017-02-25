class AddCardCommentJob < ActiveJob::Base
  queue_as :default

  def perform(_violation, _comment)
    trello_comment = trello_client.add_card_comment(_violation.card_tid, _comment)
    _violation.update_column(:comment_tid, trello_comment.tid)
  end

  def trello_client
    @trello_client ||= TrelloUtils.summon_the_monkey
  end
end
