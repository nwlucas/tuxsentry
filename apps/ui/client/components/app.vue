<template lang="pug">
#app
  nprogress-container
  section.hero.is-bold.app-navbar
    .hero-head
      nav.nav.has-shadow
        .nav-left.hero-brand
          a.nav-item.is-brand.logo(href="/")
            img(src="~images/logo.png", alt="TuxSentryUI")
          router-link.nav-item.is-tab.is-hidden-mobile(to="/dashboard") Dashboard
          router-link.nav-item.is-tab.is-hidden-mobile(to="/services") Services
          router-link.nav-item.is-tab.is-hidden-mobile(to="/logs") Logs
          router-link.nav-item.is-tab.is-hidden-mobile(to="/docs") Docs
        span#nav-toggle.nav-toggle
          span
          span
          span
  router-view
</template>
<script>
  import NprogressContainer from 'vue-nprogress/src/NprogressContainer';

  export default {
    name: 'AppEntry',
    components: {
      NprogressContainer
    }
  };
</script>
<style lang="scss">
  @import '~animate.css';
  .animated {
    animation-duration: .377s;
  }

  @import '~bulma';
  @import '~bulma/sass/utilities/variables';

  $fa-font-path: '~font-awesome/fonts/';
  @import '~font-awesome/scss/font-awesome';

  $gray-dark:                 #383e4b;
  $gray:                      #9da0a8;
  $gray-light:                #c7cbd5;
  $gray-lighter:              #e4e6eb;
  $gray-lightest:             #f0f2f7;

  html, body {
    background-color: #f5f5f5;
    color: $gray-dark;
  }

  .nprogress-container {
    position: fixed !important;
    width: 100%;
    height: 50px;
    z-index: 2048;
    pointer-events: none;
    #nprogress {
      $color: #48e79a;
      .bar {
        background: $color;
      }
      .peg {
        box-shadow: 0 0 10px $color, 0 0 5px $color;
      }
      .spinner-icon {
        border-top-color: $color;
        border-left-color: $color;
      }
    }
  }

  .app-navbar {
    position: fixed;
    min-width: 100%;
    z-index: 1024;
    box-shadow: 0 2px 3px rgba(17, 17, 17, 0.1), 0 0 0 1px rgba(17, 17, 17, 0.1);
    background-color: #36a9e1;
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
      background-color: #1e8fc6;
      min-width: 180px;
      color: #36AC70;
    }
  }
</style>
