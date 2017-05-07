import Vue from 'vue';
import axios from 'axios';
import VueAxios from 'vue-axios';
import NProgress from 'vue-nprogress';
import { sync } from 'vuex-router-sync';
import AppEntry from 'components/app';
import store from './store';
import router from './router';
import * as filters from './filters';

Vue.config.productionTip = false;

Vue.use(VueAxios, axios);
Vue.use(NProgress);

const nprogress = new NProgress({ parent: '.nprogress-container' });

sync(store, router);

Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key]);
});

/* eslint-disable no-new */
const app = new Vue({
  store,
  router,
  nprogress,
  ...AppEntry,
});

export { app, router, store };
