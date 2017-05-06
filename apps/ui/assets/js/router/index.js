import Vue from 'vue';
import Router from 'vue-router';

/* eslint-disable no-extraneous-dependencies */
import Container from 'components/layout/app-container';
import DashboardPage from 'views/dashboard';
import LogsPage from 'views/logs';
import ServicesPage from 'views/services';

Vue.use(Router);

export default new Router({
  mode: 'history',
  linkActiveClass: 'open active',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    {
      path: '/',
      redirect: '/dashboard',
      component: Container,
      children: [
        {
          path: 'dashboard',
          name: 'Dashboard',
          component: DashboardPage,
        },
        {
          path: 'services',
          name: 'Services',
          component: ServicesPage,
        },
        {
          path: 'logs',
          name: 'Logs',
          component: LogsPage,
        },
      ],
    },
  ],
});
