require "rails_helper"

describe LawAttribute do
  describe "#initialize" do
    context "with name only" do
      before { @attr = described_class.new("limit") }

      it { expect(@attr.name).to eq(:limit) }
      it { expect(@attr.label).to eq("Límite") }
      it { expect(@attr.attr_type).to eq(:string) }
      it { expect(@attr.default).to eq(nil) }
    end

    context "changing type and options" do
      before { @attr = described_class.new("limit", :integer, 1) }

      it { expect(@attr.name).to eq(:limit) }
      it { expect(@attr.label).to eq("Límite") }
      it { expect(@attr.attr_type).to eq(:integer) }
      it { expect(@attr.default).to eq(1) }
    end

    it "raises error with invalid type" do
      expect { described_class.new("limit", :invalid) }.to raise_error("invalid attribute type")
    end
  end

  describe "#to_hash" do
    let(:response) do
      {
        name: :limit,
        label: "Límite",
        attr_type: :integer,
        default: 1,
        validations: {
          type: {
            value: "Integer",
            msg: "debe ser de tipo entero"
          },
          required: {
            value: true,
            msg: "es requerido"
          }
        }
      }
    end

    before do
      @attr = described_class.new(:limit, :integer, 1)
      @attr.validators << LawValidator.new(:type, value: "Integer")
      @attr.validators << LawValidator.new(:required, value: true)
    end

    it { expect(@attr.to_hash).to eq(response) }
  end
end
