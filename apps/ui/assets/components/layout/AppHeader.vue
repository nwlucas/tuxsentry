<template lang="pug">
  .hero-head
    nav.nav.has-shadow
      .nav-left.hero-brand.logo
        a.nav-item(href="#")
          img(src="~images/logo.png", alt="TuxSentryUI")
        router-link.nav-item.is-tab.is-hidden-mobile(to="/dashboard")
          | Dashboard
        router-link.nav-item.is-tab.is-hidden-mobile(to="/services")
          | Services
        router-link.nav-item.is-tab.is-hidden-mobile(to="/logs")
          | Logs
        router-link.nav-item.is-tab.is-hidden-mobile(to="/docs")
          | Docs
      span.nav-toggle
        span
        span
        span
</template>
<script>
  export default {
    name: 'AppHeader',
    components: {
    },
    methods: {
      click() {

      },
      sidebarToggle(e) {
        e.preventDefault();
        document.body.classList.toggle('sidebar-hidden');
      },
      mobileSidebarToggle(e) {
        e.preventDefault();
        document.body.classList.toggle('sidebar-mobile-show');
      },
      asideToggle(e) {
        e.preventDefault();
        document.body.classList.toggle('aside-menu-hidden');
      },
    },
  };
</script>
<style lang="scss">
  @import '~bulma/sass/utilities/variables';

  .app-navbar {
    position: fixed;
    min-width: 100%;
    z-index: 1024;
    box-shadow: 0 2px 3px rgba(17, 17, 17, 0.1), 0 0 0 1px rgba(17, 17, 17, 0.1);
    .container {
      margin: auto 10px;
    }
    .nav-right {
      align-items: stretch;
      align-items: stretch;
      flex: 1;
      justify-content: flex-end;
      overflow: hidden;
      overflow-x: auto;
      white-space: nowrap;
    }
  }
  .hero-brand {
    .logo {
      margin-left: 10px;
      color: #36AC70;
    }
  }
</style>
