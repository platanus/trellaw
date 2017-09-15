BOARD_SCHEMA = {
  type: 'object',
  properties: {
    id: { type: 'string' },
    type: { type: 'string' },
    attributes: {
      type: 'object',
      properties: {
        tid: { type: 'string' },
        name: { type: 'string' },
        description: { type: 'string' },
        lists: {
          type: 'array',
          items: {
            type: 'object',
            properties: {
              tid: { type: 'string' },
              name: { type: 'string' }
            },
            required: ['tid', 'name']
          }
        },
        laws: {
          type: 'array',
          items: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              law: { type: 'string' },
              settings: { type: 'object' }
            },
            required: ['id', 'law', 'settings']
          }
        }
      },
      required: ['tid', 'name', 'description', 'lists', 'laws']
    }
  },
  required: ['id', 'type']
}
