<template>
  <div class="card-container">
    <card class="card-container__card" v-for="law in laws" v-bind:key="law.id" :law="law"></card>
  </div>
</template>

<style lang="scss" scoped>
.card-container {
  display: flex;
  flex-flow: row wrap;
  align-content: center;
  justify-content: space-between;

  &__card {
    margin-bottom: 3px;
    background-color: #fff;
  }
}
</style>

<script>
import card from './card';

export default {
  components: {
    card,
  },
  computed: {
    laws() {
      return this.$store.getters.laws;
    },
  }
}
</script>
