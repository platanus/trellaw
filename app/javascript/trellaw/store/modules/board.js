import Vue from 'vue';

import * as types from '../mutation-types';
import boardApi from '../../api/boards';

export default {
  namespaced: true,
  state: {
    name: null,
    description: null,
    listIds: [],
    lists: {},
    loading: false,
  },
  getters: {
    lists: state => state.listIds.map(listId => state.lists[listId]),
  },
  mutations: {
    [types.GET_BOARD](state) {
      Vue.set(state, 'loading', true);
    },
    [types.GET_BOARD_SUCCESS](state, board) {
      const listIds = [];
      const lists = {};
      board.attributes.lists.forEach((list) => {
        listIds.push(list.tid);
        lists[list.tid] = { ...list };
        lists[list.tid].laws = board.attributes.laws.filter((law) => law['list-tid'] === list.tid);
      });

      Object.assign(state, {
        name: board.attributes.name,
        description: board.attributes.description,
        lists,
        listIds,
        loading: false,
      });
    },
    [types.GET_BOARD_FAIL](state) {
      Vue.set(state, 'loading', false);
    },
  },
  actions: {
    getBoard({ commit }, boardId) {
      commit(types.GET_BOARD);

      return boardApi.getBoard(boardId)
        .then((board) => commit(types.GET_BOARD_SUCCESS, board.data))
        .catch((err) => {
          console.error(err);
          commit(types.GET_BOARD_FAIL, err);
        });
    },
  },
};
