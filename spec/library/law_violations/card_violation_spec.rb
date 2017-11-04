require "rails_helper"

describe LawViolations::CardViolation do
  let(:violation) { create(:card_violation) }

  describe "#set_violation_settings" do
    def set_violation_settings
      violation.set_violation_settings(settings)
    end

    let(:card) { double }
    let(:attributes) { double }
    let(:settings) do
      {
        card: card,
        attributes: attributes
      }
    end

    context "with valid settings" do
      before { set_violation_settings }

      it { expect(violation.card).to eq(card) }
      it { expect(violation.send(:detected_violation_card)).to eq(card) }
      it { expect(violation.attributes).to eq(attributes) }
    end

    context "with missing card" do
      let(:card) { nil }

      it { expect { set_violation_settings }.to raise_error("card is required") }
    end

    context "with missing attributes" do
      let(:attributes) { nil }

      it { expect { set_violation_settings }.to raise_error("law attributes are required") }
    end
  end
end
