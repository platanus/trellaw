require 'rails_helper'

RSpec.describe LawDsl do
  describe "#attribute" do
    context "without attributes" do
      let(:dummy_class) do
        Class.new do
          include LawDsl
        end
      end

      it { expect(dummy_class.law_attributes).to eq([]) }
    end

    context "adding attributes" do
      let(:dummy_class) do
        Class.new do
          include LawDsl

          attribute :limit, :integer, 1
          attribute :days
        end
      end

      before { @attrs = dummy_class.law_attributes }

      it { expect(@attrs.count).to eq(2) }
      it { expect(@attrs.first.name).to eq(:limit) }
      it { expect(@attrs.first.attr_type).to eq(:integer) }
      it { expect(@attrs.first.default).to eq(1) }
      it { expect(@attrs.last.name).to eq(:days) }
      it { expect(@attrs.last.attr_type).to eq(:string) }
      it { expect(@attrs.last.default).to be_nil }
    end

    it "raises error trying to nest attributes" do
      expect do
        Class.new do
          include LawDsl

          attribute :limit do
            attribute :days
          end
        end
      end.to raise_error("nest attribute method is not allowed")
    end
  end
end
