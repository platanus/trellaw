BOARD_LAW_SCHEMA = {
  type: 'object',
  properties: {
    id: { type: 'string' },
    type: { type: 'string' },
    attributes: {
      type: 'object',
      properties: {
        law: { type: 'string' },
        'list-tid': { type: 'string' },
        settings: { type: 'object' }
      },
      required: ['law', 'list-tid', 'settings']
    }
  },
  required: ['id', 'type']
}
