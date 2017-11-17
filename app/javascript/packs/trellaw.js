/* eslint-disable no-unused-vars */
import 'babel-polyfill';
import Vue from 'vue';
import App from '../trellaw/app.vue';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue(App).$mount('#app');
});
