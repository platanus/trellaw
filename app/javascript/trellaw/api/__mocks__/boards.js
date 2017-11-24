export const boardResponse = {
  data: {
    id: '1',
    type: 'board',
    attributes: {
      tid: '5a05f6ff0335b111eccb6fe4',
      name: 'trellaw_test',
      description: '',
      lists: [
        { tid: '5a05f6ff0335b111eccb6fe5', name: 'To Do' },
        { tid: '5a05f6ff0335b111eccb6fe6', name: 'Doing' },
        { tid: '5a05f6ff0335b111eccb6fe7', name: 'Done' },
      ],
      laws: [
        { id: 1, law: 'card_limit', 'list-tid': '5a05f6ff0335b111eccb6fe5', settings: { limit: 3 } },
        { id: 2, law: 'member_limit', 'list-tid': '5a05f6ff0335b111eccb6fe7', settings: { limit: 5 } },
      ],
    },
  },
};

const TIMEOUT_TIME = 300;

export default {
  getBoard(id) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (boardResponse.data.id === id) {
          resolve(boardResponse);
        } else {
          reject();
        }
      }, TIMEOUT_TIME);
    });
  },
};
