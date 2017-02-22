require 'rails_helper'

RSpec.describe BoardLaw, type: :model do
  it "has a valid factory" do
    expect(build(:board_law).valid?).to be true
  end

  subject(:board_law) { create(:board_law) }

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:board) }
    it { is_expected.to validate_presence_of(:law) }
    it { is_expected.to allow_value('dummy').for(:law) }
    it { is_expected.not_to allow_value('foo').for(:law) }
  end
end
