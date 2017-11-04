require 'swagger_helper'

describe 'API V1 Board Laws' do
  path '/board_laws/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:id) { board_law.id }
    let(:board_law) { create(:board_law, :with_settings) }

    get 'Retrieves board law' do
      produces 'application/json'
      description 'Retrieves specific board law data'

      response '200', 'ok' do
        schema(
          type: 'object',
          properties: {
            data: { '$ref' => '#/definitions/board_law' }
          }
        )

        run_test!
      end

      response '404', 'board law not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/boards/{board_id}/laws' do
    parameter name: :board_id, in: :path, type: :string
    let(:board_id) { board.id }
    let(:board) { create(:board) }

    post 'Creates board law' do
      consumes 'application/json'
      description "Creates a new board's law"
      parameter name: :board_law, in: :body, schema: {
        type: :object,
        properties: {
          law: { type: :string },
          list_tid: { type: :string },
          settings: { type: :object }
        }
      }

      let(:board_law) do
        {
          law: "member_limit",
          list_tid: "xxx",
          settings: {
            limit: 10
          }
        }
      end

      response '201', 'created' do
        schema(
          type: 'object',
          properties: {
            data: { '$ref' => '#/definitions/board_law' }
          }
        )

        run_test!
      end

      response '422', 'board law is invalid' do
        before { board_law[:law] = "invalid" }

        run_test!
      end

      response '404', 'board not found' do
        let(:board_id) { 'invalid' }

        run_test!
      end

      response '500', 'missing params' do
        let(:board_law) {}

        run_test!
      end
    end
  end
end
