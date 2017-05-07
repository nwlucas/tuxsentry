import Vue from 'vue';
import Router from 'vue-router';

/* eslint-disable no-extraneous-dependencies */
import DashboardPage from 'views/dashboard';
import LogsPage from 'views/logs';
import ServicesPage from 'views/services';

Vue.use(Router);

export default new Router({
  mode: 'history',
  linkActiveClass: 'is-active',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: DashboardPage,
    },
    {
      path: '/services',
      name: 'Services',
      component: ServicesPage,
    },
    {
      path: '/logs',
      name: 'Logs',
      component: LogsPage,
    },
    {
      path: '/docs',
      name: 'Docs',
      component: LogsPage,
    },
  ],
});
