require "rails_helper"

describe LawViolations::ListViolation do
  let(:violation) { create(:list_violation) }

  describe "#set_violation_settings" do
    def set_violation_settings
      violation.set_violation_settings(settings)
    end

    let(:cards) { [double, double] }
    let(:attributes) { double }
    let(:settings) do
      {
        cards: cards,
        attributes: attributes
      }
    end

    context "with valid settings" do
      before { set_violation_settings }

      it { expect(violation.cards).to eq(cards) }
      it { expect(violation.send(:detected_violation_card)).to eq(cards.last) }
      it { expect(violation.attributes).to eq(attributes) }
    end

    context "with missing cards" do
      let(:cards) { nil }

      it { expect { set_violation_settings }.to raise_error("cards attribute is required") }
    end

    context "with missing attributes" do
      let(:attributes) { nil }

      it { expect { set_violation_settings }.to raise_error("law attributes are required") }
    end
  end
end
