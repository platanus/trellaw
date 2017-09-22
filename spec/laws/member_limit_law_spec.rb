require 'rails_helper'

RSpec.describe MemberLimitLaw do
  let(:settings) { {} }
  let(:law) { described_class.new(settings) }

  describe "#get_settings_error" do
    it { expect(law.get_settings_error).not_to be_nil }

    context "with invalid limit format" do
      let(:settings) do
        { limit: 'foo' }
      end

      it { expect(law.get_settings_error).not_to be_nil }
    end

    context "with invalid limit" do
      let(:settings) do
        { limit: 0 }
      end

      it { expect(law.get_settings_error).not_to be_nil }
    end

    context "with valid limit" do
      let(:settings) do
        { limit: 1 }
      end

      it { expect(law.get_settings_error).to be_nil }
    end
  end

  describe "#check_violations" do
    let(:settings) do
      { limit: 1 }
    end

    let(:bad_card) { build(:trello_card, member_tids: ['member_1', 'member_2']) }
    let(:good_card) { build(:trello_card, member_tids: ['member_1']) }

    it "adds a a violation for each card that has more than members than the :limit param" do
      law.check_violations([bad_card, good_card])
      violations = law.violations
      expect(violations.count).to eq(1)
      expect(violations.last.violation).to eq('max_members')
      expect(violations.last.card_tid).to eq(bad_card.tid)
    end
  end

  context "law base" do
    let(:law_name) { :member_limit }
    let(:required_card_properties) { [] }

    it_behaves_like :law_base
  end
end
