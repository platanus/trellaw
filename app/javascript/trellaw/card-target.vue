<template>
  <div class="card-target">
    <img :src="add" />
  </div>
</template>

<script>
import add from '../trellaw/images/add.svg'

export default {
  data() {
    return {
      add,
    }
  }
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
