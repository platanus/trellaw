/* eslint-disable no-unused-vars */
import Vue from 'vue';
import App from './app.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app: Vue = new Vue(<any> App).$mount('#app');
});
