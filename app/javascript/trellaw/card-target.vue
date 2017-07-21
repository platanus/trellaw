<template>
  <div class="card-target">
    <img :src="add" />
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import Component from 'vue-class-component';

import add from '../trellaw/images/add.svg';

@Component
export default class CardTarget extends Vue {
  public add: string = add;
}
</script>

<style scoped>
  .card-target {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 103px;
  }
</style>
