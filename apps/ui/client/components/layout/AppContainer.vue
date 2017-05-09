<template lang="pug">
  #app-container
    Sidebar
    AppMain
    AppFooter
</template>
<script>
  import AppMain from 'layout/AppMain';
  import Sidebar from 'layout/Sidebar';
  import AppFooter from 'layout/AppFooter';

  export default {
    name: 'AppContainer',
    components: {
      AppMain,
      Sidebar,
      AppFooter
    }
  };
</script>
<style lang="scss">

</style>
