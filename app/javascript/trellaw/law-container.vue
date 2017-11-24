<template>
  <div class="law-container">
    <div class="law-container__laws">
      <law v-for="law in laws" v-bind:key="law.id" :law="law" class="law-container__law"></law>
    </div>
  </div>
</template>

<script>
import law from './law';

export default {
  components: {
    law,
  },
  props: ['laws'],
}
</script>

<style lang="scss" scoped>
@import './stylesheets/variables';

.law-container {
  background: $list-bg;

  &__laws {
    margin: 0 auto;
    max-width: 992px;
    display: flex;
    flex-flow: row wrap;
    align-content: center;
    justify-content: center;
    padding: 24px 4px;

    &:after {
      content: '';
      flex: auto;
    }
  }

  &__law {
    margin: 0 4px 8px;
  }
}
</style>
