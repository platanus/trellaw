require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user).valid?).to be true
  end

  subject(:user) { create(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:boards) }
  end
end
