require 'rails_helper'

RSpec.describe Api::V1::ViolationsController do
  describe 'GET #index' do
    let!(:violation) { create(:violation, card_tid: 1) }
    let!(:finishined_violation) { create(:finished_violation, card_tid: 1) }

    before do
      get(:index, card_id: 1, format: 'json')
    end

    it 'filter violations by card' do
      expect(assigns(:violations)).to eq([violation])
    end

    it 'respond with violation json object' do
      json_response = JSON.load response.body
      serialized_violations = { "violations" => [{
          "id" => violation.id,
          "law" => violation.law,
          "violation" => violation.violation,
        }]
      }

      expect(json_response).to eq(serialized_violations)
    end
  end
end
