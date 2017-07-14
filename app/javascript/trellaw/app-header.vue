<template>
  <header class="header">
    <img :src="logo" />
  </header>
</template>

<script>
import logo from '../trellaw/images/white-monkey.svg'

export default {
  data() {
    return {
      logo,
    }
  }
}
</script>

<style lang="scss" scoped>
  @import 'stylesheets/variables';
  .header {
    background-color: $header-bg;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
