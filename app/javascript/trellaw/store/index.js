
import Vue from 'vue';
import Vuex from 'vuex';

import board from './modules/board';
import laws from './modules/laws';

Vue.use(Vuex);

export default new Vuex.Store({
  strict: true,
  modules: {
    board,
    laws,
  },
});
