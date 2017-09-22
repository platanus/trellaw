require 'rails_helper'

RSpec.describe CardLimitLaw do
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
    let(:bad_list) { [build(:trello_card), build(:trello_card)] }
    let(:good_list) { [build(:trello_card)] }
    let(:settings) do
      { limit: 1 }
    end

    it "does not add a violation on a list with :limit cards" do
      law.check_violations(good_list)
      expect(law.violations.count).to eq 0
    end

    it "adds a a violation on the last card of a list with more than :limit cards" do
      law.check_violations(bad_list)
      violations = law.violations
      expect(violations.count).to eq 1
      expect(violations.last.violation).to eq 'max_cards'
      expect(violations.last.card_tid).to eq bad_list.last.tid
    end
  end

  context "law base" do
    let(:law_name) { :card_limit }
    let(:required_card_properties) { [] }

    it_behaves_like :law_base
  end
end
