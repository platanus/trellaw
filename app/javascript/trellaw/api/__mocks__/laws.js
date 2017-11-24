export const lawsResponse = {
  data: [
    {
      id: 'member_limit',
      type: 'law',
      attributes: {
        name: 'member_limit',
        description: 'Número máximo de miembros que una tarjeta puede tener en esta lista',
        definition: 'Esta lista no puede tener tarjetas con más de {limit} miembros',
        'law-attributes': [
          {
            name: 'limit',
            label: 'Límite',
            'attr-type': 'integer',
            default: 3,
            validations: {
              required: {
                value: true,
                msg: 'es requerido',
              },
              type: {
                value: 'Integer',
                msg: 'debe ser de tipo entero',
              },
              'greater-than': {
                value: 0,
                msg: 'debe ser mayor que 0',
              },
            },
          },
        ],
      },
    },
    {
      id: 'max_days_on_list',
      type: 'law',
      attributes: {
        name: 'max_days_on_list',
        description: 'Número máximo de días que una tarjeta puede estar en esta lista',
        definition: 'Esta lista no puede tener tarjetas con más de {days} días de antigüedad',
        'law-attributes': [
          {
            name: 'days',
            label: 'Días',
            'attr-type': 'integer',
            default: 7,
            validations: {
              required: {
                value: true,
                msg: 'es requerido',
              },
              type: {
                value: 'Integer',
                msg: 'debe ser de tipo entero',
              },
              'greater-than': {
                value: 0,
                msg: 'debe ser mayor que 0',
              },
            },
          },
        ],
      },
    },
    {
      id: 'card_limit',
      type: 'law',
      attributes: {
        name: 'card_limit',
        description: 'Número máximo de tarjetas que una lista puede tener',
        definition: 'Esta lista no puede tener más de {limit} tarjetas',
        'law-attributes': [
          {
            name: 'limit',
            label: 'Límite',
            'attr-type': 'integer',
            default: 5,
            validations: {
              required: {
                value: true,
                msg: 'es requerido',
              },
              type: {
                value: 'Integer',
                msg: 'debe ser de tipo entero',
              },
              'greater-than': {
                value: 0,
                msg: 'debe ser mayor que 0',
              },
            },
          },
        ],
      },
    },
  ],
};

const TIMEOUT_TIME = 300;

export default {
  getLaws() {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(lawsResponse);
      }, TIMEOUT_TIME);
    });
  },
};
