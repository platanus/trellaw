import lawsModule from './laws';
import * as types from '../mutation-types';
import testHelpers from '../../../helpers/testing';
import { lawsResponse } from '../../api/__mocks__/laws';

jest.mock('../../api/laws');

const { mutations, actions } = lawsModule;

describe('mutations', () => {
  let state = { ...mutations.state };

  it('GET_LAWS changes loading status to true', () => {
    mutations[types.GET_LAWS](state);
    expect(state.loading).toBe(true);
  });

  it('GET_LAWS_SUCCESS changes loading status to false', () => {
    mutations[types.GET_LAWS_SUCCESS](state, lawsResponse.data);
    expect(state.loading).toBe(false);
  });

  it('GET_LAWS_SUCCESS assigns laws', () => {
    state = { ...mutations.state };
    mutations[types.GET_LAWS_SUCCESS](state, lawsResponse.data);
    expect(state.laws).toMatchObject({
      'member_limit': { id: 'member_limit' },
      'max_days_on_list': { id: 'max_days_on_list' },
      'card_limit': { id: 'card_limit' },
    });
  });

  it('GET_LAWS_SUCCESS assigns law ids', () => {
    state = { ...mutations.state };
    mutations[types.GET_LAWS_SUCCESS](state, lawsResponse.data);
    expect(state.lawIds).toEqual(['member_limit', 'max_days_on_list', 'card_limit']);
  });

  it('GET_LAWS_FAIL sets loading status to false', () => {
    state = { loading: true };
    mutations[types.GET_LAWS_FAIL](state);
  });
});

describe('actions', () => {
  describe('getLaws', () => {
    it('sends GET_LAWS_SUCCESS on success', done => {
      testHelpers.testAction(
        actions.getLaws,
        '',
        {},
        [{ type: types.GET_LAWS }, { type: types.GET_LAWS_SUCCESS, payload: lawsResponse.data }],
        done
      );
    });
  });
});
