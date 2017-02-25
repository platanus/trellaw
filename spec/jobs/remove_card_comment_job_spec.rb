require 'rails_helper'

RSpec.describe RemoveCardCommentJob, type: :job do
  let(:client) { mock_ham_trello_client }
  let(:violation) { create(:violation, comment_tid: 'tid') }

  it "calls edit_card_comment and then resets the violation comment_tid" do
    expect(client).to receive(:edit_card_comment).with(violation.comment_tid, instance_of(String))
      .and_return build(:trello_comment)

    expect { RemoveCardCommentJob.perform_now(violation) }
      .to change { violation.reload.comment_tid }.to(nil)
  end
end
