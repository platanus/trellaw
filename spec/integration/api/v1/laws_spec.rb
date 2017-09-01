require 'swagger_helper'

describe 'API V1 Laws' do
  path '/laws' do
    get 'Retrieves laws' do
      produces 'application/json'
      description 'Retrieves all the available laws'

      response '200', 'ok' do
        schema(
          type: 'object',
          properties: {
            data: {
              type: 'array',
              items: { '$ref' => '#/definitions/law' }
            }
          }
        )

        run_test!
      end
    end
  end
end
