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
    it { is_expected.to validate_inclusion_of(:law).in_array(LawUtils.available_laws) }
    it { is_expected.to validate_presence_of(:list_tid) }
  end
end
