module TrelloHelpers
  class TrelloMock
    def initialize(member_tid: nil)
      @member_tid = member_tid || gen_id
    end

    def get_member_tid
      @member_tid
    end

    def board_member?(_board_tid, _member_tid)
      board_members[_board_tid].include? _member_tid
    end

    def add_board_member(_board_tid, _member_tid)
      board_members[_board_tid] |= [_member_tid]
    end

    def add_board_webhook(_board_tid, _callback)
      webhooks[gen_id] = TrelloWebhook.new.tap { |wh| wh.tid = @@last_id }
    end

    def delete_webhook(_webhook_tid)
      webhooks.delete tid
    end

    def get_own_boards
      []
    end

    def get_board(_board_tid)
      nil
    end

    def get_lists(_board_tid)
      []
    end

    def get_list(_list_tid)
      nil
    end

    private

    def gen_id
      @@last_id ||= 1
      @@last_id += 1
    end

    def board_members
      @@board_members ||= Hash.new { |h, k| h[k] = [] }
    end

    def webhooks
      @@webhooks ||= []
    end
  end

  def mock_ham_trello_client
    ham_mock = TrelloMock.new(member_tid: 'ham')
    allow(TrelloUtils).to receive(:summon_the_monkey).and_return ham_mock
    ham_mock
  end

  def mock_user_trello_client(_user)
    user_mock = TrelloMock.new(member_tid: "user_#{_user.id}")
    allow(TrelloUtils).to receive(:load_user_client).and_return user_mock
    user_mock
  end
end

RSpec.configure do |config|
  config.include TrelloHelpers
end
