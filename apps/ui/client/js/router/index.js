import Vue from 'vue';
import Router from 'vue-router';

/* eslint-disable no-extraneous-dependencies */
import AppContainer from 'layout/AppContainer';
import DashboardPage from 'views/dashboard';
import LogsPage from 'views/logs';
import ServicesPage from 'views/services';
import NotFound from 'views/notfound';

Vue.use(Router);

export default new Router({
  mode: 'history',
  linkActiveClass: 'is-active',
  scrollBehavior: () => ({ y: 0 }),
  routes: [
    {
      path: '/',
      name: 'Home',
      components: {
        default: AppContainer
      },
      children: [
        {
          path: '/dashboard',
          name: 'Dashboard',
          component: DashboardPage
        },
        {
          path: '/services',
          name: 'Services',
          component: ServicesPage
        },
        {
          path: '/logs',
          name: 'Logs',
          component: LogsPage
        }
      ]
    },
    {
      path: '/docs',
      name: 'Docs',
      component: LogsPage
    },
    {
      path: '*',
      name: 'NotFound',
      component: NotFound
    }
  ]
});
