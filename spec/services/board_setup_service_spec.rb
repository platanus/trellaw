require 'rails_helper'

describe BoardSetupService do
  let(:user) { create(:user) }
  let(:board) { create(:board, user: user) }
  let(:service) { described_class.new(board: board) }

  let!(:user_client) { mock_user_trello_client(user) }
  let!(:ham_client) { mock_ham_trello_client }

  describe '#setup' do
    it "registers ham as a board member" do
      expect(user_client)
        .to receive(:add_board_member)
        .with(board.board_tid, ham_client.get_member_tid)

      service.setup
    end

    it "registers board webhook and stores in board" do
      expect(ham_client)
        .to receive(:add_board_webhook)
        .with(board.board_tid, instance_of(String))
        .and_call_original

      expect { service.setup }.to change { board.reload.webhook_tid }.to instance_of(String)
    end

    it "does not register board webhook if skip_webhook is set" do
      expect(ham_client).not_to receive(:add_board_webhook)

      expect { service.setup(skip_webhook: true) }
        .not_to change { board.reload.webhook_tid }.from nil
    end

    context "ham is already registered as a board member" do
      before do
        allow(user_client).to receive(:board_member?).and_return true
      end

      it "does not register ham as a board member" do
        expect(user_client).not_to receive(:add_board_member)
        service.setup
      end
    end
  end
end
