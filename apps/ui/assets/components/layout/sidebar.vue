<template lang="pug">
  .sidebar
    nav.sidebar-nav
      ul.nav
        li.nav-title Dashboard
        li.nav-item
          router-link(v-bind:to="'/dashboard'", class='nav-link')
            i.icon-speedometer
            | Dashboard
        li.nav-title Functions
        li.nav-item
          router-link(v-bind:to="'/services'", class='nav-link')
            i.icon-loop
            | Services
        li.nav-item
          router-link(v-bind:to="'/logs'", class='nav-link')
            i.icon-docs
            | Logs
        li.divider
        li.nav-title Administration
</template>
<script>
  export default {
    name: 'Sidebar',
    methods: {
      handleClick (e) {
        e.preventDefault();
        e.target.parentElement.classList.toggle('open')
      }
    }
  }
</script>
<style lang="scss">
  .nav-link {
    cursor: pointer;
  }
</style>
