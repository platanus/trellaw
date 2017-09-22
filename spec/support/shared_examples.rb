RSpec.shared_examples :law_base do
  let(:law) { described_class.new({}) }

  it { expect(law.id).to eq(law_name) }
  it { expect(law.law_name).to eq(law_name) }
  it { expect(law.description).to eq(I18n.t("laws.#{law_name}.description")) }
  it { expect(law.definition).to eq(I18n.t("laws.#{law_name}.definition")) }
  it { expect(law.required_card_properties).to eq(required_card_properties) }
end
