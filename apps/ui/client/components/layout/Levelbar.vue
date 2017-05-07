<template lang="pug">
  nav.level.app-levelbar
    .level-left
      .level-item
        h3.subtitle.is-5
          strong {{ name }}
    .level-right.is-hidden-mobile
      breadcrumb(:list="list")
</template>
<script>
  import Breadcrumb from 'vue-bulma-breadcrumb';

  export default {
    name: 'LevelBar',
    components: {
      Breadcrumb,
    },

    data() {
      return {
        list: null,
      };
    },

    created() {
      this.getList();
    },

    computed: {
      name() {
        return this.$route.name;
      },
    },

    methods: {
      getList() {
        let matched = this.$route.matched.filter(item => item.name);
        const first = matched[0];
        if (first && (first.name !== 'Home' || first.path !== '')) {
          matched = [{ name: 'Home', path: '/' }].concat(matched);
        }
        this.list = matched;
      },
    },

    watch: {
      $route() {
        this.getList();
      },
    },
  };
</script>
<style lang="scss">

</style>
