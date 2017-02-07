require 'rails_helper'

describe LawService do
  def build(*_args)
    described_class.new(*_args)
  end

  describe '#available?' do
    it "returns true if law exists" do
      expect(build(law_name: 'dummy').available?).to be true
      expect(build(law_name: 'foo').available?).to be false
    end
  end

  describe '#law_class' do
    it "returns the law class" do
      expect(build(law_name: 'dummy').law_class).to be(DummyLaw)
    end
  end
end
