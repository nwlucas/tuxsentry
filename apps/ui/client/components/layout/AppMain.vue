<template lang="pug">
  section.app-main
    .container.is-fluid.is-marginless.app-content
      LevelBar
      router-view
</template>
<script>
  import LevelBar from './Levelbar';

  export default {
    name: 'AppMain',
    components: {
      LevelBar,
    },
  };
</script>
<style lang="scss">
  .app-main {
    padding-top: 50px;
    margin-left: 180px;
  }
  .app-content {
    padding: 20px;
  }
</style>
