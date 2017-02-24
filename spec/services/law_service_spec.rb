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

  describe '#description' do
    it "returns the law name if law does not implement the .description method if law exists" do
      expect(build(law_name: 'empty_dummy').description).to eq 'Empty dummy'
    end

    it "returns the result of calling the law's .description method" do
      allow(DummyLaw).to receive(:description).and_return 'foo'
      expect(build(law_name: 'dummy').description).to eq 'foo'
    end
  end

  describe '#get_settings_error' do
    it "returns error if provided settings is not nil or a Hash" do
      expect(build(law_name: 'empty_dummy').get_settings_error(nil)).to be nil
      expect(build(law_name: 'empty_dummy').get_settings_error({})).to be nil
      expect(build(law_name: 'empty_dummy').get_settings_error('foo')).not_to be nil
    end

    it "return the result of calling the law's .get_settings_error method" do
      expect(DummyLaw).to receive(:get_settings_error).with(foo: 'bar').and_return 'qux'
      expect(build(law_name: 'dummy').get_settings_error('foo' => 'bar')).to eq 'qux'
    end
  end

  describe '#required_card_properties' do
    it "returns an empty array if law does not implement 'required_card_properties'" do
      expect(build(law_name: 'empty_dummy').required_card_properties({})).to eq []
    end

    it "returns the result of calling the law's .required_card_properties" do
      expect(DummyLaw).to receive(:required_card_properties).with(foo: 'bar').and_return [:qux]
      expect(build(law_name: 'dummy').required_card_properties('foo' => 'bar')).to eq [:qux]
    end
  end

  describe '#check_violations' do
    it "returns the result of calling the law's .check_violations and sets each violation law" do
      expect(DummyLaw).to receive(:check_violations).with({ foo: 'bar' }, []).and_return []
      expect(build(law_name: 'dummy').check_violations({ 'foo' => 'bar' }, [])).to eq []
    end

    it "sets the returned violations 'law' property to the current law name" do
      allow(DummyLaw).to receive(:check_violations).and_return [DetectedViolation.new]
      violations = build(law_name: 'dummy').check_violations(nil, [])
      expect(violations.first.law).to eq 'dummy'
    end
  end
end
