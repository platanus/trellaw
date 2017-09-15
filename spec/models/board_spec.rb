require 'rails_helper'

RSpec.describe Board, type: :model do
  it "has a valid factory" do
    expect(build(:board).valid?).to be true
  end

  subject(:board) { create(:board) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:board_laws) }
    it { is_expected.to have_many(:violations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:board_tid) }
    it { is_expected.to validate_uniqueness_of(:board_tid) }
  end

  describe '#trello_lists' do
    let(:trello_client) { double(get_lists: "list") }

    before do
      expect(TrelloUtils).to receive(:load_user_client).with(subject.user).and_return(trello_client)
    end

    it { expect(subject.trello_lists).to eq("list") }
  end

  describe 'trello board attributes' do
    let(:get_board_result) do
      double(
        tid: 'X',
        name: 'Lean',
        description: 'desc'
      )
    end

    let(:trello_client) { double(get_board: get_board_result) }

    before do
      expect(TrelloUtils).to receive(:load_user_client).with(subject.user).and_return(trello_client)
    end

    it { expect(subject.tid).to eq('X') }
    it { expect(subject.name).to eq('Lean') }
    it { expect(subject.description).to eq('desc') }
  end
end
