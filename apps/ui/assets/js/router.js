import Vue from 'vue';
import Router from 'vue-router';

import Container from '../components/app-container';
import Dashboard from '../components/dashboard';
import LogsPage from '../components/logs';
import ServicesPage from '../components/services';

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
          component: Dashboard,
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
