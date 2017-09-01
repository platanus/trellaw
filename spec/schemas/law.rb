LAW_SCHEMA = {
  type: 'object',
  properties: {
    id: { type: 'string' },
    type: { type: 'string' },
    attributes: {
      type: 'object',
      properties: {
        name: { type: 'string' },
        description: { type: 'string' },
        definition: { type: 'string' },
        'law-attributes': {
          type: 'array',
          items: { '$ref' => '#/definitions/law_attribute' }
        }
      },
      required: ['name', 'description', 'definition', 'law-attributes']
    }
  },
  required: ['id', 'type']
}
