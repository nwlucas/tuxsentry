import Vue from 'vue';
import AppEntry from 'components/app';
import store from './store';
import router from './router';


Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
  el: '#tuxUi',
  store,
  router,
  template: '<AppEntry/>',
  components: {
    AppEntry,
  },
});

