<template>
  <header class="header">
    <img :src="logo" />
  </header>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';
import logo from '../trellaw/images/white-monkey.svg';

export default class AppHeader extends Vue {
  public logo: string = logo;
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
