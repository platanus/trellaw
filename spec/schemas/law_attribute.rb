LAW_ATTRIBUTE_SCHEMA = {
  type: 'object',
  properties: {
    name: { type: 'string' },
    'attr-type': { type: 'string' },
    validations: { type: 'object' }
  },
  required: ['name', 'attr-type', 'validations']
}
