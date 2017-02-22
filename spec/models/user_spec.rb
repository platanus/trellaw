require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user).valid?).to be true
  end

  subject(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:boards) }
  end

  describe '#linked?' do
    it "returns true if user has an assigned trello_access_token" do
      expect(user.linked?).to be false
      user.trello_access_token = 'sometoken'
      expect(user.linked?).to be true
    end
  end
end
