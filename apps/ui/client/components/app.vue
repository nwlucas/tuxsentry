<template lang="pug">
  #app-container
    nprogress-container
    section.hero.is-bold.app-navbar
      AppHeader
    Sidebar
    AppMain
    AppFooter
</template>
<script>
  import NprogressContainer from 'vue-nprogress/src/NprogressContainer';
  import AppHeader from 'layout/AppHeader';
  import AppMain from 'layout/AppMain';
  import Sidebar from 'layout/Sidebar';
  import AppFooter from 'layout/AppFooter';

  export default {
    name: 'AppContainer',
    components: {
      AppHeader,
      AppMain,
      Sidebar,
      AppFooter,
      NprogressContainer,
    },
  };
</script>
<style lang="scss">
  @import '~animate.css';
  .animated {
    animation-duration: .377s;
  }

  @import '~bulma';

  $fa-font-path: '~font-awesome/fonts/';
  @import '~font-awesome/scss/font-awesome';

  html, body {
    background-color: whitesmoke;
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
</style>
