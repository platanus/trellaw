<template>
  <div class="card">
    <slot></slot>
  </div>
</template>

<script>
export default {}
</script>

<style lang="scss" scoped>
@import './stylesheets/variables';

.card {
  display: flex;
  height: 103px;
  margin-bottom: 8px;
  background-color: $card-bg;
  border-radius: 4px;
}
</style>
