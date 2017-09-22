require 'rails_helper'

RSpec.describe LawBase do
  let(:some_law) do
    Class.new(LawBase)
  end

  let(:some_law_instance) do
    some_law.new({})
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

  describe '#attributes' do
    it "returns attributes array" do
      attr1 = LawAttribute.new(:limit, :integer, 1)
      attr1.validators << LawValidator.new(:type, value: "Integer")
      attr1.validators << LawValidator.new(:required, value: true)

      attr2 = LawAttribute.new(:days)
      attr2.validators << LawValidator.new(:type, value: "String")

      result = [
        {
          name: :limit,
          label: "Límite",
          attr_type: :integer,
          default: 1,
          validations: {
            type: {
              value: "Integer",
              msg: "debe ser de tipo entero"
            },
            required: {
              value: true,
              msg: "es requerido"
            }
          }
        },
        {
          name: :days,
          label: "Días",
          attr_type: :string,
          default: nil,
          validations: {
            type: {
              value: "String",
              msg: "debe ser de tipo texto"
            }
          }
        }
      ]

      allow(described_class).to receive(:law_attributes).and_return([attr1, attr2])
      expect(described_class.new({}).attributes).to eq(result)
    end
  end
end
