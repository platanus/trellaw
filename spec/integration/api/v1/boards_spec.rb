require 'swagger_helper'

describe 'API V1 Boards' do
  path '/boards/{id}' do
    parameter name: :id, in: :path, type: :string

    let(:id) { board.id }
    let(:board) { create(:board) }
    let!(:user_client) { mock_user_trello_client(board.user) }

    get 'Retrieves board' do
      produces 'application/json'
      description 'Retrieves specific board data'

      response '200', 'ok' do
        schema(
          type: 'object',
          properties: {
            data: { '$ref' => '#/definitions/board' }
          }
        )

        run_test!
      end

      response '404', 'board not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
