require 'rails_helper'

RSpec.describe MaxDaysOnListLaw do
  describe ".get_settings_error" do
    it "ensures 'days' is a greater than zero integer" do
      expect(described_class.get_settings_error({})).not_to be nil
      expect(described_class.get_settings_error(days: 'foo')).not_to be nil
      expect(described_class.get_settings_error(days: 0)).not_to be nil
      expect(described_class.get_settings_error(days: 1)).to be nil
    end
  end

  describe ".required_card_properties" do
    it "returns the movement property" do
      expect(described_class.required_card_properties({})).to eq [:movement]
    end
  end

  describe ".check_violations" do
    let(:bad_card) { build(:trello_card, added_at: 3.day.ago) }
    let(:good_card) { build(:trello_card, added_at: 1.day.ago) }

    it "adds a violation for each card that was added before :days days ago" do
      violations = described_class.check_violations({ days: 2 }, [bad_card, good_card])
      expect(violations.count).to eq 1
      expect(violations.last.violation).to eq 'max_days'
      expect(violations.last.card_tid).to eq bad_card.tid
    end
  end
end
