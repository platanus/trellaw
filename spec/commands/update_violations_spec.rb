require 'rails_helper'

describe UpdateViolations do
  let(:client) { mock_ham_trello_client }
  let(:board) { create(:board) }

  let!(:law_1) { create(:board_law, board: board, list_tid: 'tid_1') }
  let!(:law_2) { create(:board_law, board: board, list_tid: 'tid_2') }

  let!(:card_1) { build(:trello_card) }
  let!(:card_2) { build(:trello_card) }
  let!(:card_3) { build(:trello_card) }

  def perform
    described_class.for(board: board)
  end

  before do
    allow(client).to receive(:get_cards).with(list_tid: 'tid_1', properties: [])
      .and_return([card_1])

    allow(client).to receive(:get_cards).with(list_tid: 'tid_2', properties: [])
      .and_return([card_2, card_3])
  end

  it "calls check_violations for each law" do
    expect(DummyLaw).to receive(:check_violations).with(law_1.settings, [card_1])
      .and_call_original

    expect(DummyLaw).to receive(:check_violations).with(law_2.settings, [card_2, card_3])
      .and_call_original

    perform
  end

  it "sets each violation list_tid before applying" do
    violation = build(:detected_violation)
    allow(DummyLaw).to receive(:check_violations).and_return([violation], [])
    expect { perform }.to change { violation.list_tid }.to 'tid_1'
  end

  it "applies the concatenated list of returned violations to the board" do
    violation_1 = build(:detected_violation)
    violation_2 = build(:detected_violation)

    allow(DummyLaw).to receive(:check_violations).and_return([violation_1], [violation_2])

    expect(ApplyViolations).to receive(:for)
      .with(board: board, detected_violations: [violation_1, violation_2])

    perform
  end

  context "when one of the laws applies to the complete board" do
    let!(:law_3) { create(:board_law, board: board, list_tid: nil) }
    let!(:card_4) { build(:trello_card) }

    before do
      allow(client).to receive(:get_cards).with(list_tid: 'tid_3', properties: [])
        .and_return([card_4])

      allow(client).to receive(:get_lists).with(board.board_tid)
        .and_return([build(:trello_list, tid: 'tid_1'), build(:trello_list, tid: 'tid_3')])
    end

    it "call check_violations for every board list - law match" do
      expect(DummyLaw).to receive(:check_violations).with(law_1.settings, [card_1])
        .and_call_original

      expect(DummyLaw).to receive(:check_violations).with(law_3.settings, [card_1])
        .and_call_original

      expect(DummyLaw).to receive(:check_violations).with(law_3.settings, [card_4])
        .and_call_original

      perform
    end
  end
end
