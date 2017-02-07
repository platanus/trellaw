require 'rails_helper'

describe LawService do
  def build(*_args)
    described_class.new(*_args)
  end

  describe '.available_laws' do
    it "returns a string array" do
      expect(described_class.available_laws).to all be_a(String)
    end
  end

  describe '#law_class' do
    it "returns the law class" do
      expect(build(law_name: 'dummy').law_class).to be(DummyLaw)
    end
  end
end
