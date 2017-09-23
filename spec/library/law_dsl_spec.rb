require 'rails_helper'

RSpec.describe LawDsl do
  before do
    begin
      Object.send(:remove_const, :TestLaw)
    rescue NameError
      # do nothing
    end
  end

  describe "#attribute" do
    context "without attributes" do
      before do
        described_class.new(:test) do
          # do nothing
        end
      end

      it { expect(TestLaw.law_attributes).to eq([]) }
    end

    context "adding attributes" do
      before do
        described_class.new(:test) do
          attribute :limit, :integer, 1
          attribute :days
        end

        @attrs = TestLaw.law_attributes
      end

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
        described_class.new(:test) do
          attribute :limit do
            attribute :days
          end
        end
      end.to raise_error("nest attribute method is not allowed")
    end
  end

  context "adding validations" do
    before do
      described_class.new(:test) do
        attribute(:limit, :integer, 5) do
          validate(required: true, greater_than: 0)
        end
      end

      @attrs = TestLaw.law_attributes
      @validators = @attrs.first.validators
    end

    it { expect(@validators.count).to eq(2) }
    it { expect(@validators.first.rule).to eq(:required) }
    it { expect(@validators.first.options).to eq(value: true) }
    it { expect(@validators.last.rule).to eq(:greater_than) }
    it { expect(@validators.last.options).to eq(value: 0) }

    it "raises error if given rules are not a hash" do
      expect do
        described_class.new(:test) do
          attribute(:limit, :integer, 5) do
            validate("not a hash")
          end
        end
      end.to raise_error("rules need to be a Hash")
    end

    it "raises error trying to run validate outside of attribute context" do
      expect do
        described_class.new(:test) do
          validate(required: true, greater_than: 0)
        end
      end.to raise_error("validate needs to run inside attribute block")
    end
  end
end
