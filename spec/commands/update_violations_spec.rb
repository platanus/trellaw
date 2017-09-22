require 'rails_helper'

describe UpdateViolations do
  let(:client) { mock_ham_trello_client }
  let(:board) { create(:board) }

  let!(:board_law1) { create(:board_law, board: board, list_tid: 'tid_1') }
  let!(:board_law2) { create(:board_law, board: board, list_tid: 'tid_2') }
  let!(:law1) { board_law1.law_instance  }
  let!(:law2) { board_law2.law_instance }

  let!(:card1) { build(:trello_card) }
  let!(:card2) { build(:trello_card) }
  let!(:card3) { build(:trello_card) }

  def perform
    described_class.for(board: board)
  end

  before do
    allow(board).to receive(:board_laws).and_return([board_law1, board_law2])
    allow(board_law1).to receive(:law_instance).and_return(law1)
    allow(board_law2).to receive(:law_instance).and_return(law2)
    allow(client).to receive(:get_list_cards).with('tid_1', properties: []).and_return([card1])
    allow(client).to receive(:get_list_cards)
      .with('tid_2', properties: []).and_return([card2, card3])
  end

  it "calls get_list_cards for each list, passing each law's required properties" do
    allow(law1).to receive(:required_card_properties).and_return([:foo])
    allow(law2).to receive(:required_card_properties).and_return([:bar])
    expect(client).to receive(:get_list_cards).with('tid_1', properties: [:foo]).and_return([])
    expect(client).to receive(:get_list_cards).with('tid_2', properties: [:bar]).and_return([])

    perform
  end

  it "calls check_violations for each law" do
    expect(law1).to receive(:check_violations).with([card1]).and_call_original
    expect(law2).to receive(:check_violations).with([card2, card3]).and_call_original

    perform
  end

  it "sets each violation list_tid before applying" do
    violation = build(:detected_violation)

    expect(law1).to receive(:violations).and_return([violation])
    expect(law2).to receive(:violations).and_return([])

    expect { perform }.to change { violation.list_tid }.to('tid_1')
  end

  it "applies the concatenated list of returned violations to the board" do
    violation1 = build(:detected_violation)
    violation2 = build(:detected_violation)

    expect(law1).to receive(:violations).and_return([violation1])
    expect(law2).to receive(:violations).and_return([violation2])

    expect(ApplyViolations).to receive(:for)
      .with(board: board, detected_violations: [violation1, violation2])

    perform
  end

  context "when one of the laws applies to the complete board" do
    let!(:board_law3) { create(:board_law, board: board, list_tid: nil) }
    let!(:law3) { board_law3.law_instance }
    let!(:card4) { build(:trello_card) }

    before do
      allow(board).to receive(:board_laws).and_return([board_law1, board_law2, board_law3])
      allow(board_law3).to receive(:law_instance).and_return(law3)
      allow(client).to receive(:get_list_cards).with('tid_3', properties: []).and_return([card4])
      allow(client).to receive(:get_lists)
        .with(board.board_tid)
        .and_return([build(:trello_list, tid: 'tid_1'), build(:trello_list, tid: 'tid_3')])
    end

    it "call check_violations for every board list - law match" do
      expect(law1).to receive(:check_violations).with([card1]).and_call_original
      expect(law3).to receive(:check_violations).with([card1]).and_call_original
      expect(law3).to receive(:check_violations).with([card4]).and_call_original

      perform
    end
  end
end
