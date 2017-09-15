require "rails_helper"

describe LawValidator do
  describe "#initialize" do
    context "with valid params" do
      before { @validator = described_class.new(:required) }

      it { expect(@validator.rule).to eq(:required) }
      it { expect(@validator.options).to eq({}) }
    end

    it "raises error with invalid rule" do
      expect { described_class.new(:invalid) }.to raise_error("invalid rule: invalid")
    end
  end

  context "working with required rule" do
    before { @validator = described_class.new(:required) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("es requerido") }
    end

    describe "#validate" do
      it { expect(@validator.validate(nil)).to eq(false) }
      it { expect(@validator.validate("")).to eq(false) }
      it { expect(@validator.validate(1)).to eq(true) }
    end
  end

  context "working with greater_than rule" do
    let(:max) { 0 }
    before { @validator = described_class.new(:greater_than, value: max) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("debe ser mayor que #{max}") }
    end

    describe "#validate" do
      it { expect(@validator.validate(nil)).to eq(true) }
      it { expect(@validator.validate(max + 1)).to eq(true) }
      it { expect(@validator.validate(max)).to eq(false) }
      it { expect(@validator.validate(max - 1)).to eq(false) }
    end
  end

  context "working with type rule" do
    let(:required_type) { "Integer" }
    before { @validator = described_class.new(:type, value: required_type) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("debe ser de tipo entero") }
    end

    describe "#validate" do
      it { expect(@validator.validate(1)).to eq(true) }
      it { expect(@validator.validate("1")).to eq(true) }
      it { expect(@validator.validate(1.0)).to eq(false) }
      it { expect(@validator.validate(nil)).to eq(true) }
    end
  end
end
