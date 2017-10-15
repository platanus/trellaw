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

  describe "#violations" do
    before do
      @violations = described_class.law_violations
      @violation = @violations.first
    end

    it { expect(@violations.count).to eq(1) }
    it { expect(@violation.name).to eq(:max_members) }
    it { expect(@violation.law_name).to eq(:member_limit) }
    it { expect(@violation.condition_proc).to be_a(Proc) }

    describe "#max_members violation" do
      let(:member_tids_count) { 2 }
      let(:member_tids) { double(:member_tids, count: member_tids_count) }
      let(:card) { double(:card, member_tids: member_tids, tid: "X") }
      let(:limit) { 3 }
      let(:attributes) { { limit: limit } }
      let(:violation_settigns) do
        {
          card: card,
          attributes: attributes
        }
      end

      def check_max_members
        @violation.check(violation_settigns)
      end

      it { expect(check_max_members).to be_nil }

      context "with detected violation" do
        let(:member_tids_count) { 4 }

        it { expect(check_max_members).to be_a(DetectedViolation) }

        it "sets valid comment" do
          expect(check_max_members.comment).to eq(
            I18n.t("laws.member_limit.violations.max_members.many", limit: limit)
          )
        end

        context "when limit has value 1" do
          let(:limit) { 1 }

          it "sets valid comment" do
            expect(check_max_members.comment).to eq(
              I18n.t("laws.member_limit.violations.max_members.one", limit: limit)
            )
          end
        end
      end
    end
  end

  context "law base" do
    let(:law_name) { :member_limit }
    let(:required_card_properties) { [] }

    it_behaves_like :law_base
  end
end
