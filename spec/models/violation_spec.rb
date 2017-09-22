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
      violation1 = create(:violation)
      _violation2 = create(:violation, finished_at: Time.current)
      violation3 = create(:violation)

      expect(Violation.active).to eq([violation1, violation3])
    end
  end
end
