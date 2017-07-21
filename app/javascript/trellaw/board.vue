<template>
  <div class="board">
    <list class="board__list" :title="'Ideas'"></list>
    <list class="board__list" :title="'Backlog'"></list>
    <list class="board__list" :title="'This Sprint'"></list>
    <list class="board__list" :title="'In Process'"></list>
    <list class="board__list" :title="'Done'"></list>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

import list from './list.vue';

@Component({
  components: {
    list,
  },
})
export default class Board extends Vue { }
</script>


<style lang="scss" scoped>
@import './stylesheets/variables';

.board {
  padding: 45px 5px 24px;
  white-space: nowrap;
  overflow-x: auto;

  &__list {
    display: inline-block;
    margin: 0 5px;
    width: 270px;
    height: 100%;
  }
}
</style>
