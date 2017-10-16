require 'rails_helper'

RSpec.describe LawBase do
  let(:settings) do
    {}
  end

  let(:some_law) do
    Class.new(LawBase)
  end

  let(:some_law_instance) do
    some_law.new(settings)
  end

  describe '#config' do
    let(:law_attributes) do
      [
        LawAttribute.new("attr1", :integer),
        LawAttribute.new(:attr2)
      ]
    end

    let(:settings) do
      {
        "attr1" => "1",
        attr2: "value"
      }
    end

    before { expect(LawBase).to receive(:law_attributes).and_return(law_attributes) }

    it "returns law attributes with values" do
      attrs = some_law_instance.config
      expect(attrs.count).to eq(2)
      expect(attrs.first.name).to eq(:attr1)
      expect(attrs.first.value).to eq(1)
      expect(attrs.last.name).to eq(:attr2)
      expect(attrs.last.value).to eq("value")
    end
  end
end
