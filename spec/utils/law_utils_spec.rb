require 'rails_helper'

describe LawUtils do
  describe '#active_laws' do
    it "returns available laws" do
      law_names = described_class.active_laws.map(&:law_name).map(&:to_s)
      expect(law_names).to contain_exactly(*LawUtils::ACTIVE_LAWS)
    end
  end

  describe '#law_instance' do
    let(:law_name) { :member_limit }
    let(:settings) { { "limit" => 1 } }
    let(:law_instance) { described_class.law_instance(law_name, settings) }

    it { expect(law_instance).to be_a(MemberLimitLaw) }
    it { expect(law_instance.send(:settings)).to eq(limit: 1) }

    context "with invalid law name" do
      let(:law_name) { :invalid }

      it { expect { law_instance }.to raise_error(NameError) }
    end
  end

  describe '#law_class' do
    let(:law_name) { :member_limit }
    let(:law_class) { described_class.law_class(law_name) }

    it { expect(law_class).to eq(MemberLimitLaw) }

    context "with invalid law name" do
      let(:law_name) { :invalid }

      it { expect { law_class }.to raise_error(NameError) }
    end
  end

  describe '#law_class_name' do
    let(:law_name) { :member_limit }
    let(:law_class_name) { described_class.law_class_name(law_name) }

    it { expect(law_class_name).to eq("MemberLimitLaw") }
  end

  describe '#law_available?' do
    let(:law_name) { :member_limit }
    let(:execute) { described_class.law_available?(law_name) }

    it { expect(execute).to eq(true) }

    context "with invalid law name" do
      let(:law_name) { :invalid }

      it { expect(execute).to eq(false) }
    end
  end
end
