<template>
  <div class="board">
    <list class="board__list" :title="'Ideas'"></list>
    <list class="board__list" :title="'Backlog'"></list>
    <list class="board__list" :title="'This Sprint'"></list>
    <list class="board__list" :title="'In Process'"></list>
    <list class="board__list" :title="'Done'"></list>
  </div>
</template>

<script>
import list from './list';

export default {
  components: {
    list,
  }
}
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
