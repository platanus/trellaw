import Vue from 'vue';

import * as types from '../mutation-types';
import lawsApi from '../../api/laws';

export default {
  namespaced: true,
  state: {
    lawIds: [],
    laws: {},
    loading: false,
  },
  getters: {
    laws: state => state.lawIds.map(lawId => state.laws[lawId]),
    getLawById: (state) => (lawId) => state.laws[lawId],
  },
  mutations: {
    [types.GET_LAWS](state) {
      Vue.set(state, 'loading', true);
    },
    [types.GET_LAWS_SUCCESS](state, lawsArr) {
      const lawIds = [];
      const laws = {};
      lawsArr.forEach((law) => {
        lawIds.push(law.id);
        laws[law.id] = { ...law, ...law.attributes };
        delete laws[law.id].attributes;
      });

      Object.assign(state, {
        laws,
        lawIds,
        loading: false,
      });
    },
    [types.GET_LAWS_FAIL](state) {
      Vue.set(state, 'loading', false);
    },
  },
  actions: {
    getLaws({ commit }) {
      commit(types.GET_LAWS);

      return lawsApi.getLaws()
        .then((laws) => commit(types.GET_LAWS_SUCCESS, laws.data))
        .catch((err) => {
          commit(types.GET_LAWS_FAIL, err);
        });
    },
  },
};
