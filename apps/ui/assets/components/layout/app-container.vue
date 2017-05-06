<template lang="pug">
  .app
    AppHeader
    .app-body
      Sidebar
      main.main
        breadcrumb.mb-0(:list="list")
        .container-fluid
          router-view
    AppFooter
</template>
<script>
  import AppHeader from 'layout/app-header';
  import Sidebar from 'layout/sidebar';
  import AppAside from 'layout/app-aside';
  import AppFooter from 'layout/app-footer';
  import Breadcrumb from 'layout/breadcrumb';

  export default {
    name: 'AppContainer',
    components: {
      AppHeader,
      Sidebar,
      AppAside,
      AppFooter,
      Breadcrumb
    },
    computed: {
      name() {
          return this.$route.name
      },

      list() {
          return this.$route.matched
      }
    }
  };
</script>
<style lang="scss">

</style>
