require "rails_helper"

describe LawValidator do
  let(:integer_attr) { @attr = LawAttribute.new("limit", :integer, 1) }

  describe "#initialize" do
    context "with valid params" do
      before { @validator = described_class.new(integer_attr, :required) }

      it { expect(@validator.law_attr).to eq(integer_attr) }
      it { expect(@validator.rule).to eq(:required) }
      it { expect(@validator.options).to eq({}) }
    end

    it "raises error with invalid attr" do
      expect { described_class.new(:invalid, :integer) }.to(
        raise_error("invalid LawAttribute instance")
      )
    end

    it "raises error with invalid rule" do
      expect { described_class.new(integer_attr, :invalid) }.to raise_error("invalid rule")
    end
  end

  context "working with required rule" do
    before { @validator = described_class.new(integer_attr, :required) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("limit is required") }
    end

    describe "#validate" do
      it { expect(@validator.validate(nil)).to eq(false) }
      it { expect(@validator.validate("")).to eq(false) }
      it { expect(@validator.validate(1)).to eq(true) }
    end
  end
end
