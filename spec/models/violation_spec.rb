require 'rails_helper'

RSpec.describe Violation, type: :model do
  it "has a valid factory" do
    expect(build(:violation).valid?).to be true
  end

  subject(:violation) { create(:violation) }

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:board) }
    it { is_expected.to validate_presence_of(:violation) }
    it { is_expected.to validate_presence_of(:card_tid) }
    it { is_expected.to validate_presence_of(:law) }
    it { is_expected.to allow_value('dummy').for(:law) }
    it { is_expected.not_to allow_value('foo').for(:law) }
  end

  describe '.active' do
    it "returns only active violations" do
      violation_1 = create(:violation)
      _violation_2 = create(:violation, finished_at: Time.current)
      violation_3 = create(:violation)

      expect(Violation.active).to eq([violation_1, violation_3])
    end
  end
end
