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
    let!(:user_client) { mock_user_trello_client(subject.user) }

    it { expect(subject.trello_lists).to eq([]) }
  end

  describe 'trello board attributes' do
    let!(:user_client) { mock_user_trello_client(subject.user) }

    it { expect(subject.tid).to eq('tid value') }
    it { expect(subject.name).to eq('name value') }
    it { expect(subject.description).to eq('description value') }
  end
end
