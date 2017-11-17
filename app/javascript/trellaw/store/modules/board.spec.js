import boardModule from './board';
import * as types from '../mutation-types';

const { mutations } = boardModule;

describe('mutations', () => {
  const mockBoard = {
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
        { id: 1, law: 'card_limit', settings: { limit: 3 } },
        { id: 2, law: 'member_limit', settings: { limit: 5 } },
      ],
    },
  };

  let state = { ...mutations.state };

  it('GET_BOARDS changes loading status to true', () => {
    mutations[types.GET_BOARD](state);
    expect(state.loading).toBe(true);
  });

  it('GET_BOARDS_SUCCESS changes loading status to false', () => {
    mutations[types.GET_BOARD_SUCCESS](state, mockBoard);
    expect(state.loading).toBe(false);
  });

  it('GET_BOARDS_SUCCESS sets board name', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, mockBoard);
    expect(state.name).toBe('trellaw_test');
  });

  it('GET_BOARDS_SUCCESS assigns lists', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, mockBoard);
    expect(state.lists).toEqual({
      '5a05f6ff0335b111eccb6fe5': { tid: '5a05f6ff0335b111eccb6fe5', name: 'To Do' },
      '5a05f6ff0335b111eccb6fe6': { tid: '5a05f6ff0335b111eccb6fe6', name: 'Doing' },
      '5a05f6ff0335b111eccb6fe7': { tid: '5a05f6ff0335b111eccb6fe7', name: 'Done' },
    });
  });

  it('GET_BOARDS_SUCCESS assigns lists ids', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, mockBoard);
    expect(state.listIds).toEqual([
      '5a05f6ff0335b111eccb6fe5',
      '5a05f6ff0335b111eccb6fe6',
      '5a05f6ff0335b111eccb6fe7',
    ]);
  });

  it('GET_BOARDS_FAIL sets loading status to false', () => {
    state = { loading: true };
    mutations[types.GET_BOARD_FAIL](state);
  });
});
