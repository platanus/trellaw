<template>
  <div class="list-wrapper">
    <div class="list">
      <div class="list__header">{{title}}</div>
      <div class="list__content">
        <card :card-type="dropTarget"></card>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

import card from './card.vue';
import cardTarget from './card-target.vue';

@Component({
  components: {
    card,
  },
  props: {
    title: {
      default: 'Título',
    },
  },
})
export default class List extends Vue {
  public dropTarget: Vue.Component = cardTarget;
  public title: string;
}
</script>


<style lang="scss" scoped>
  @import './stylesheets/variables';

  .list-wrapper {
    background-color: $list-bg;
    border-radius: 4px;
  }

  .list {
    display: flex;
    flex-flow: column;
    padding: 0 8px;
    height: 100%;

    &__header {
      font-weight: 600;
      font-size: 14px;
      flex: 40px 0 0;
      line-height: 40px;
    }

    &__content {
      background-color: $list-content-bg;
      flex: 100% 1 1;
      border-radius: 4px;
      padding: 8px;
    }
  }
</style>
