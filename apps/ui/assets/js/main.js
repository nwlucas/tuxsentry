import Vue from 'vue';
import AppEntry from '../components/app';
import router from './router';


Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#tuxUi',
  router,
  template: '<AppEntry/>',
  components: {
    AppEntry,
  },
});

