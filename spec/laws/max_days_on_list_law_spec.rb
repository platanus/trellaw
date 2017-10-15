require 'rails_helper'

RSpec.describe MaxDaysOnListLaw do
  let(:settings) { {} }
  let(:law) { described_class.new(settings) }
  let(:now) { Time.zone.local(1984, 6, 4, 0, 0, 0) }
  before { Timecop.freeze(now) }
  after { Timecop.return }

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

  describe "#violations" do
    before do
      @violations = described_class.law_violations
      @violation = @violations.first
    end

    it { expect(@violations.count).to eq(1) }
    it { expect(@violation.name).to eq(:max_days) }
    it { expect(@violation.law_name).to eq(:max_days_on_list) }
    it { expect(@violation.condition_proc).to be_a(Proc) }

    describe "#max_days violation" do
      let(:added_at) { now }
      let(:card) { double(:card, added_at: added_at, tid: "X") }
      let(:days) { 3 }
      let(:attributes) { { days: days } }
      let(:violation_settigns) do
        {
          card: card,
          attributes: attributes
        }
      end

      def check_max_days
        @violation.check(violation_settigns)
      end

      it { expect(check_max_days).to be_nil }

      context "with detected violation" do
        let(:added_at) { now - 4.days }

        it { expect(check_max_days).to be_a(DetectedViolation) }
        it { expect(check_max_days.card_tid).to eq(card.tid) }
        it { expect(check_max_days.law).to eq(:max_days_on_list) }
        it { expect(check_max_days.violation).to eq(:max_days) }

        it "sets valid comment" do
          expect(check_max_days.comment).to eq(
            I18n.t("laws.max_days_on_list.violations.max_days.many", days: days)
          )
        end

        context "when days has value 1" do
          let(:days) { 1 }

          it "sets valid comment" do
            expect(check_max_days.comment).to eq(
              I18n.t("laws.max_days_on_list.violations.max_days.one", days: days)
            )
          end
        end
      end
    end
  end

  context "law base" do
    let(:law_name) { :max_days_on_list }
    let(:required_card_properties) { [:movement] }

    it_behaves_like :law_base
  end
end
