require "rails_helper"

describe LawAttribute do
  describe "#initialize" do
    context "with name only" do
      before { @attr = described_class.new("limit") }

      it { expect(@attr.name).to eq(:limit) }
      it { expect(@attr.attr_type).to eq(:string) }
      it { expect(@attr.default).to eq(nil) }
    end

    context "changing type and default" do
      before { @attr = described_class.new("limit", :integer, 1) }

      it { expect(@attr.name).to eq(:limit) }
      it { expect(@attr.attr_type).to eq(:integer) }
      it { expect(@attr.default).to eq(1) }
    end

    it "raises error with invalid type" do
      expect { described_class.new("limit", :invalid) }.to raise_error("invalid attribute type")
    end
  end

  describe "#to_param" do
    let(:response) do
      {
        name: :limit,
        attr_type: :integer,
        default: 1
      }
    end

    before { @attr = described_class.new(:limit, :integer, 1) }

    it { expect(@attr.to_param).to eq(response) }
  end
end
