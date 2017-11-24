<template>
  <card class="card--law">
    {{law.name}}<br>
    {{settings}}
  </card>
</template>

<script>
import card from './card';

export default {
  components: {
    card,
  },
  props: ['settings', 'law'],
}
</script>

<style lang="scss" scoped>
.card--law {
  text-align: center;
  justify-content: center;
  align-items: center;
}
</style>

