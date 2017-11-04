require "rails_helper"

describe LawViolation do
  let(:comment) { double }
  let(:name) { "foo" }
  let(:law_name) { "member_limit" }
  let(:condition_proc) { Proc.new { true } }

  let(:settings) do
    {
      name: name,
      law_name: law_name,
      condition_proc: condition_proc
    }
  end

  def violation
    described_class.new(settings)
  end

  describe "#initialize" do
    it { expect(violation.name).to eq(name.to_sym) }
    it { expect(violation.law_name).to eq(law_name.to_sym) }
    it { expect(violation.condition_proc).to eq(condition_proc) }

    context "with missing name" do
      let(:name) { nil }

      it { expect { violation }.to raise_error("violation name is required") }
    end

    context "with missing law name" do
      let(:law_name) { nil }

      it { expect { violation }.to raise_error("valid law name is required") }
    end

    context "with invalid law name" do
      let(:law_name) { "invalid" }

      it { expect { violation }.to raise_error("valid law name is required") }
    end

    context "with missing condition" do
      let(:condition_proc) { nil }

      it { expect { violation }.to raise_error("violation condition proc is required") }
    end
  end

  describe "#check" do
    def check
      violation.check({})
    end

    it { expect { check }.to raise_error("you need to set detected_violation_card attribute") }

    context "with detected_violation_card" do
      let(:tid) { "X" }
      let(:detected_violation_card) { double(:detected_violation_card, tid: tid) }

      before do
        allow_any_instance_of(LawViolation).to(
          receive(:detected_violation_card).and_return(detected_violation_card)
        )
      end

      it { expect(check).to be_a(DetectedViolation) }
      it { expect(check.law).to eq(law_name.to_sym) }
      it { expect(check.violation).to eq(name.to_sym) }
      it { expect(check.card_tid).to eq(tid) }
      it { expect(check.comment).to eq("undefined violation default msg") }
    end

    context "with condition returning false" do
      let(:condition_proc) { Proc.new { false } }

      it { expect(check).to be_nil }
    end
  end
end
