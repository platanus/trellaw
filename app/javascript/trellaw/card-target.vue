<template>
  <card class="card--target">
    <img :src="add" />
  </card>
</template>

<script>
import add from '../trellaw/images/add.svg'
import card from './card';

export default {
  components: {
    card,
  },
  data() {
    return {
      add,
    }
  }
}
</script>

<style lang="scss" scoped>
@import './stylesheets/variables';

.card--target {
  background-color: $card-target-bg;
  justify-content: center;
  align-items: center;
}
</style>
