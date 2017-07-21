<template>
  <div class="card">
    <component :is="cardType"></component>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

@Component({
  props: ['cardType'],
})
export default class Card extends Vue {
  public cardType: string;
}
</script>

<style lang="scss" scoped>
@import './stylesheets/variables';

.card {
  background-color: $card-bg;
  border-radius: 4px;
}
</style>
