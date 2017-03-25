require 'rails_helper'

RSpec.describe CardLimitLaw do
  describe ".get_settings_error" do
    it "ensures 'limit' is a greater than zero integer" do
      expect(described_class.get_settings_error({})).not_to be nil
      expect(described_class.get_settings_error(limit: 'foo')).not_to be nil
      expect(described_class.get_settings_error(limit: 0)).not_to be nil
      expect(described_class.get_settings_error(limit: 1)).to be nil
    end
  end

  describe ".check_violations" do
    let(:bad_list) { [build(:trello_card), build(:trello_card)] }
    let(:good_list) { [build(:trello_card)] }

    it "does not add a violation on a list with :limit cards" do
      violations = described_class.check_violations({ limit: 1 }, good_list)
      expect(violations.count).to eq 0
    end

    it "adds a a violation on the last card of a list with more than :limit cards" do
      violations = described_class.check_violations({ limit: 1 }, bad_list)
      expect(violations.count).to eq 1
      expect(violations.last.violation).to eq 'max_cards'
      expect(violations.last.card_tid).to eq bad_list.last.tid
    end
  end
end
