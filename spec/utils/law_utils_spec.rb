require 'rails_helper'

describe LawUtils do
  describe '.available_laws' do
    it "returns a string array" do
      expect(described_class.available_laws).to all be_a(String)
    end
  end
end
