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

  context "adding validations" do
    let(:dummy_class) do
      Class.new do
        include LawDsl

        attribute(:limit, :integer, 5) do
          validate(required: true, greater_than: 0)
        end
      end
    end

    before do
      @attrs = dummy_class.law_attributes
      @validators = @attrs.first.validators
    end

    it { expect(@validators.count).to eq(2) }
    it { expect(@validators.first.law_attr).to eq(@attrs.first) }
    it { expect(@validators.first.rule).to eq(:required) }
    it { expect(@validators.first.options).to eq(value: true) }
    it { expect(@validators.last.law_attr).to eq(@attrs.first) }
    it { expect(@validators.last.rule).to eq(:greater_than) }
    it { expect(@validators.last.options).to eq(value: 0) }

    it "raises error if given rules are not a hash" do
      expect do
        Class.new do
          include LawDsl

          attribute(:limit, :integer, 5) do
            validate("not a hash")
          end
        end
      end.to raise_error("rules needs to be a Hash")
    end

    it "raises error trying to run valdate outside of attribute context" do
      expect do
        Class.new do
          include LawDsl

          validate(required: true, greater_than: 0)
        end
      end.to raise_error("validate needs to run inside attribute block")
    end
  end
end
