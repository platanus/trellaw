require "rails_helper"

describe LawValidator do
  let(:attr_name) { "my-attribute" }
  let(:integer_attr) { @attr = LawAttribute.new(attr_name, :integer, 1) }

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
      expect { described_class.new(integer_attr, :invalid) }.to raise_error("invalid rule: invalid")
    end
  end

  context "working with required rule" do
    before { @validator = described_class.new(integer_attr, :required) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("#{attr_name} is required") }
    end

    describe "#validate" do
      it { expect(@validator.validate(nil)).to eq(false) }
      it { expect(@validator.validate("")).to eq(false) }
      it { expect(@validator.validate(1)).to eq(true) }
    end
  end

  context "working with greater_than rule" do
    let(:max) { 0 }
    before { @validator = described_class.new(integer_attr, :greater_than, value: max) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("#{attr_name} must be greater than #{max}") }
    end

    describe "#validate" do
      it { expect(@validator.validate(max + 1)).to eq(true) }
      it { expect(@validator.validate(max)).to eq(false) }
      it { expect(@validator.validate(max - 1)).to eq(false) }
    end
  end

  context "working with type rule" do
    let(:required_type) { Integer }
    before { @validator = described_class.new(integer_attr, :type, value: required_type) }

    describe "#error_message" do
      it { expect(@validator.error_message).to eq("#{attr_name} must be #{required_type}") }
    end

    describe "#validate" do
      it { expect(@validator.validate(1)).to eq(true) }
      it { expect(@validator.validate("1")).to eq(false) }
      it { expect(@validator.validate(1.0)).to eq(false) }
      it { expect(@validator.validate(nil)).to eq(false) }
    end
  end
end
