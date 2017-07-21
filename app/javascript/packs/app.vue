<template>
  <div class="app">
    <app-header class="app__header"></app-header>
    <board class="app__board"></board>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

import appHeader from '../trellaw/app-header.vue';
import board from '../trellaw/board.vue';

@Component({
    components: {
    appHeader,
    board,
  },
})
export default class App extends Vue {}
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
