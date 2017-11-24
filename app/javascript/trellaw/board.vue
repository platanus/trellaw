<template>
  <div class="board">
    <list class="board__list" v-for="list in lists" :key="list.tid" :list="list"></list>
  </div>
</template>

<script>
import list from './list';

export default {
  props: ['lists'],
  components: {
    list,
  },
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
    min-height: 100%;
  }
}
</style>
