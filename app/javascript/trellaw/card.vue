<template>
  <div class="card">
    <component :is="cardType"></component>
  </div>
</template>

<script>
export default {
  props: ['cardType'],
}
</script>

<style lang="scss" scoped>
  @import './stylesheets/variables';

  .card {
    background-color: $card-bg;
    border-radius: 4px;
  }
</style>
