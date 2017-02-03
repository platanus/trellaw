require 'rails_helper'

describe TrelloUtils do
  describe '.summon_the_monkey' do
    it "returns a new TrelloClient instance" do
      expect(described_class.summon_the_monkey).to be_a TrelloClient
    end
  end

  describe '.load_user_client' do
    it "returns a new TrelloClient instance" do
      expect(described_class.load_user_client(create(:user))).to be_a TrelloClient
    end
  end
end
