require 'rails_helper'

RSpec.describe BoardLaw, type: :model do
  it "has a valid factory" do
    expect(build(:board_law).valid?).to be true
  end

  subject(:board_law) { build(:board_law, law: 'dummy') }

  describe 'associations' do
    it { is_expected.to belong_to(:board) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:board) }
    it { is_expected.to validate_presence_of(:law) }
    it { is_expected.to validate_uniqueness_of(:law).scoped_to(:board_id, :list_tid) }
    it { is_expected.to allow_value('dummy').for(:law) }
    it { is_expected.not_to allow_value('foo').for(:law) }
    it { is_expected.to allow_value(nil).for(:list_tid) }

    context "when law returns no errors" do
      before { allow_any_instance_of(DummyLaw).to receive(:get_settings_error).and_return(nil) }

      it { is_expected.to allow_value(:foo).for(:settings) }
    end

    context "when law returns errors" do
      before { allow_any_instance_of(DummyLaw).to receive(:get_settings_error).and_return('err') }

      it { is_expected.not_to allow_value(:foo).for(:settings) }
    end
  end
end
