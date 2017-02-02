require 'rails_helper'

RSpec.describe Law, type: :model do
  it "has a valid factory" do
    expect(build(:law).valid?).to be true
  end

  subject(:law) { create(:law) }
end
