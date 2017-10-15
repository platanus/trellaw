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

  describe "#violations" do
    before do
      @violations = described_class.law_violations
      @violation = @violations.first
    end

    it { expect(@violations.count).to eq(1) }
    it { expect(@violation.name).to eq(:max_cards) }
    it { expect(@violation.law_name).to eq(:card_limit) }
    it { expect(@violation.condition_proc).to be_a(Proc) }

    describe "#max_cards violation" do
      let(:c1) { double(:c1, tid: "c1") }
      let(:c2) { double(:c2, tid: "c2") }
      let(:cards) { [c1, c2] }
      let(:limit) { 3 }
      let(:attributes) { { limit: limit } }
      let(:violation_settigns) do
        {
          cards: cards,
          attributes: attributes
        }
      end

      def check_max_cards
        @violation.check(violation_settigns)
      end

      it { expect(check_max_cards).to be_nil }

      context "with detected violation" do
        let(:c3) { double(:c3, tid: "c3") }
        let(:c4) { double(:c4, tid: "c4") }

        before do
          cards << c3
          cards << c4
        end

        it { expect(check_max_cards).to be_a(DetectedViolation) }
        it { expect(check_max_cards.card_tid).to eq(c4.tid) }
        it { expect(check_max_cards.law).to eq(:card_limit) }
        it { expect(check_max_cards.violation).to eq(:max_cards) }

        it "sets valid comment" do
          expect(check_max_cards.comment).to eq(
            I18n.t("laws.card_limit.violations.max_cards.many", limit: limit)
          )
        end

        context "when limit has value 1" do
          let(:limit) { 1 }

          it "sets valid comment" do
            expect(check_max_cards.comment).to eq(
              I18n.t("laws.card_limit.violations.max_cards.one", limit: limit)
            )
          end
        end
      end
    end
  end

  context "law base" do
    let(:law_name) { :card_limit }
    let(:required_card_properties) { [] }

    it_behaves_like :law_base
  end
end
