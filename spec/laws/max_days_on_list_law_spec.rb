require 'rails_helper'

RSpec.describe MaxDaysOnListLaw do
  let(:settings) { {} }
  let(:law) { described_class.new(settings) }

  describe "#get_settings_error" do
    it { expect(law.get_settings_error).not_to be_nil }

    context "with invalid days format" do
      let(:settings) do
        { days: 'foo' }
      end

      it { expect(law.get_settings_error).not_to be_nil }
    end

    context "with invalid days" do
      let(:settings) do
        { days: 0 }
      end

      it { expect(law.get_settings_error).not_to be_nil }
    end

    context "with valid days" do
      let(:settings) do
        { days: 1 }
      end

      it { expect(law.get_settings_error).to be_nil }
    end
  end

  describe "#required_card_properties" do
    it "returns the movement property" do
      expect(law.required_card_properties).to eq [:movement]
    end
  end

  describe "#check_violations" do
    let(:bad_card) { build(:trello_card, added_at: 3.day.ago) }
    let(:good_card) { build(:trello_card, added_at: 1.day.ago) }
    let(:settings) do
      { days: 2 }
    end

    it "adds a violation for each card that was added before :days days ago" do
      law.check_violations([bad_card, good_card])
      violations = law.violations
      expect(violations.count).to eq(1)
      expect(violations.last.violation).to eq('max_days')
      expect(violations.last.card_tid).to eq(bad_card.tid)
    end
  end

  context "law base" do
    let(:law_name) { :max_days_on_list }
    let(:required_card_properties) { [:movement] }

    it_behaves_like :law_base
  end
end
