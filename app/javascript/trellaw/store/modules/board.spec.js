import boardModule from './board';
import * as types from '../mutation-types';
import testHelpers from '../../../helpers/testing';
import { boardResponse } from '../../api/__mocks__/boards';

jest.mock('../../api/boards');

const { mutations, actions } = boardModule;

describe('mutations', () => {
  let state = { ...mutations.state };

  it('GET_BOARDS changes loading status to true', () => {
    mutations[types.GET_BOARD](state);
    expect(state.loading).toBe(true);
  });

  it('GET_BOARDS_SUCCESS changes loading status to false', () => {
    mutations[types.GET_BOARD_SUCCESS](state, boardResponse.data);
    expect(state.loading).toBe(false);
  });

  it('GET_BOARDS_SUCCESS sets board name', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, boardResponse.data);
    expect(state.name).toBe('trellaw_test');
  });

  it('GET_BOARDS_SUCCESS assigns lists', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, boardResponse.data);
    expect(state.lists).toEqual({
      '5a05f6ff0335b111eccb6fe5': {
        tid: '5a05f6ff0335b111eccb6fe5',
        name: 'To Do',
        laws: [
          {
            id: 1,
            law: 'card_limit',
            'list-tid': '5a05f6ff0335b111eccb6fe5',
            settings: {
              limit: 3,
            },
          },
        ],
      },
      '5a05f6ff0335b111eccb6fe6': { tid: '5a05f6ff0335b111eccb6fe6', name: 'Doing', laws: [] },
      '5a05f6ff0335b111eccb6fe7': {
        tid: '5a05f6ff0335b111eccb6fe7',
        name: 'Done',
        laws: [
          {
            id: 2,
            law: 'member_limit',
            'list-tid': '5a05f6ff0335b111eccb6fe7',
            settings: {
              limit: 5,
            },
          },
        ],
      },
    });
  });

  it('GET_BOARDS_SUCCESS assigns lists ids', () => {
    state = { ...mutations.state };
    mutations[types.GET_BOARD_SUCCESS](state, boardResponse.data);
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

describe('actions', () => {
  describe('getBoard', () => {
    it('sends GET_BOARD_SUCCESS on success', done => {
      testHelpers.testAction(
        actions.getBoard,
        '1',
        {},
        [{ type: types.GET_BOARD }, { type: types.GET_BOARD_SUCCESS, payload: boardResponse.data }],
        done
      );
    });

    it('sends GET_BOARD_FAIL on failure', done => {
      testHelpers.testAction(
        actions.getBoard,
        '2',
        {},
        [{ type: types.GET_BOARD }, { type: types.GET_BOARD_FAIL }],
        done
      );
    });
  });
});
