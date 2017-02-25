require 'rails_helper'

RSpec.describe LawBase do
  let(:some_law) do
    Class.new(LawBase)
  end

  let(:some_law_instance) do
    some_law.new({})
  end

  describe '.check_violations' do
    it "creates a new instance, calls check_violations on instance and returns violations" do
      expect(some_law).to receive(:new).with(:foo).and_return some_law_instance
      expect(some_law_instance).to receive(:check_violations).with :bar
      expect(some_law_instance).to receive(:violations).and_return :qux
      expect(some_law.check_violations(:foo, :bar)).to eq :qux
    end
  end

  describe '#add_violations' do
    let(:card) { build(:trello_card) }

    it "adds violations to the `violations` array" do
      expect { some_law_instance.add_violation(card, 'violation', comment: 'comment') }
        .to change { some_law_instance.violations.count }.by(1)

      expect(some_law_instance.violations.last.card_tid).to eq(card.tid)
      expect(some_law_instance.violations.last.violation).to eq('violation')
      expect(some_law_instance.violations.last.comment).to eq('comment')
    end
  end
end
