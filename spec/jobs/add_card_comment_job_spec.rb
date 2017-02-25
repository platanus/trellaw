require 'rails_helper'

RSpec.describe AddCardCommentJob, type: :job do
  let(:client) { mock_ham_trello_client }
  let(:violation) { create(:violation) }
  let(:comment) { build(:trello_comment) }

  it "calls add_card_comment and then updates the violation comment_tid" do
    expect(client).to receive(:add_card_comment).with(violation.card_tid, 'comment')
      .and_return comment

    expect { AddCardCommentJob.perform_now(violation, 'comment') }
      .to change { violation.reload.comment_tid }.to(comment.tid)
  end
end
