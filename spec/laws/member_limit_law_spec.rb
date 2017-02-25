require 'rails_helper'

RSpec.describe MemberLimitLaw do
  describe ".get_settings_error" do
    it "ensures 'limit' is a greater than zero integer" do
      expect(described_class.get_settings_error({})).not_to be nil
      expect(described_class.get_settings_error(limit: 'foo')).not_to be nil
      expect(described_class.get_settings_error(limit: 0)).not_to be nil
      expect(described_class.get_settings_error(limit: 1)).to be nil
    end
  end

  describe ".check_violations" do
    let(:bad_card) { build(:trello_card, member_tids: ['member_1', 'member_2']) }
    let(:good_card) { build(:trello_card, member_tids: ['member_1']) }

    it "adds a a violation for each card that has more than members than the :limit param" do
      violations = described_class.check_violations({ limit: 1 }, [bad_card, good_card])
      expect(violations.count).to eq 1
      expect(violations.last.violation).to eq 'max_members'
      expect(violations.last.card_tid).to eq bad_card.tid
    end
  end
end
