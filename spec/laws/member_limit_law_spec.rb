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

  describe "#attributes" do
    before do
      @attributes = described_class.law_attributes
      @attribute = @attributes.first
      @validators = @attribute.validators
    end

    it { expect(@attributes.count).to eq(1) }
    it { expect(@attribute.name).to eq(:limit) }
    it { expect(@attribute.attr_type).to eq(:integer) }
    it { expect(@attribute.default).to eq(3) }
    it { expect(@validators.count).to eq(3) }
    it { expect(@validators.first.options).to eq(value: true) }
    it { expect(@validators.first.rule).to eq(:required) }
    it { expect(@validators.second.options).to eq(value: "Integer") }
    it { expect(@validators.second.rule).to eq(:type) }
    it { expect(@validators.third.options).to eq(value: 0) }
    it { expect(@validators.third.rule).to eq(:greater_than) }
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
        it { expect(check_max_members.card_tid).to eq(card.tid) }
        it { expect(check_max_members.law).to eq(:member_limit) }
        it { expect(check_max_members.violation).to eq(:max_members) }

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

    it_behaves_like :law_base
  end
end
