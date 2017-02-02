require 'rails_helper'

RSpec.describe Board, type: :model do
  it "has a valid factory" do
    expect(build(:board).valid?).to be true
  end

  subject(:board) { create(:board) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:board_laws) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:board_tid) }
  end
end
