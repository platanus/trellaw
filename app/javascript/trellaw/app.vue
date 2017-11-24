<template>
  <div class="app">
    <app-header class="app__header"></app-header>
    <board class="app__board" :lists="lists"></board>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import store from './store';
import appHeader from '../trellaw/app-header.vue';
import board from '../trellaw/board.vue';

export default {
  store,
  components: {
    appHeader,
    board,
  },
  mounted() {
    if (window.boardId) {
      this.$store.dispatch('laws/getLaws');
      this.$store.dispatch('board/getBoard', window.boardId);
    }
  },
  computed: {
   ...mapGetters({
     lists: 'board/lists',
     laws: 'laws/laws',
    }),
  },
}
</script>

<style lang="scss">
@import '~normalize.css/normalize';
@import '../trellaw/stylesheets/variables';

*,
*::after,
*::before {
  box-sizing: border-box;
}

body {
  font-family: $font-family;
  background-color: $body-bg;
  color: $body-color;
}

html,
body,
.app {
  width: 100%;
  height: 100%;
}

.app {
  display: flex;
  flex-flow: column nowrap;

  &__header {
    flex: 40px 0 0;
  }

  &__board {
    flex: 100% 1 1;
  }
}
</style>
