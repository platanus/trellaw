
import Vue from 'vue';
import Vuex from 'vuex';

import board from './modules/board';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  modules: {
    board,
  },
});
