require 'rails_helper'

RSpec.describe BoardLaw, type: :model do
  it "has a valid factory" do
    expect(build(:board_law).valid?).to be true
  end

  subject(:board_law) { create(:board_law, law: 'dummy') }

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:board) }
    it { is_expected.to validate_presence_of(:law) }
    it { is_expected.to allow_value('dummy').for(:law) }
    it { is_expected.not_to allow_value('foo').for(:law) }

    it "marks settings as valid if LawService.get_settings_error returns nil" do
      allow_any_instance_of(LawService).to receive(:get_settings_error).and_return nil
      is_expected.to allow_value(:foo).for(:settings)
    end

    it "marks settings as invalid if LawService.get_settings_error returns an error" do
      allow_any_instance_of(LawService).to receive(:get_settings_error).with(nil).and_return(nil)
      allow_any_instance_of(LawService).to receive(:get_settings_error).with(:foo).and_return('err')

      is_expected.not_to allow_value(:foo).for(:settings)
    end
  end
end
