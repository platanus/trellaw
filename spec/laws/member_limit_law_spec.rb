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
end
