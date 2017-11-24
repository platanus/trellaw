<template>
  <div class="list-wrapper">
    <div class="list">
      <div class="list__header">{{list.name}}</div>
      <div class="list__content">
        <law class="list__law" v-for="listLaw in list.laws" :key="listLaw.id" :settings="listLaw.settings" :law="getLawById(listLaw.law)"></law>
        <card-target></card-target>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import law from './law';
import cardTarget from './card-target';

export default {
  components: {
    law,
    cardTarget,
  },
  props: ['list'],
  computed: {
    ...mapGetters('laws', ['getLawById']),
  }
}
</script>


<style lang="scss" scoped>
@import './stylesheets/variables';

.list-wrapper {
  background-color: $list-bg;
  border-radius: 4px;
}

.list {
  display: flex;
  flex-flow: column;
  padding: 0 8px 8px;
  height: 100%;

  &__header {
    font-weight: 600;
    font-size: 14px;
    flex: 40px 0 0;
    line-height: 40px;
  }

  &__content {
    background-color: $list-content-bg;
    flex: 100% 1 1;
    border-radius: 4px;
    padding: 8px;
  }

  &__law {
    margin-bottom: 8px;
  }
}
</style>
