<template lang="pug">
  navbar
    button.navbar-toggler.mobile-sidebar-toggler.hidden-lg-up(type="button", @click="mobileSidebarToggle")
    a.navbar-brand(href="#")
    ul.nav.navbar-nav.hidden-md-down
      li.nav-item
        a.nav-link.navbar-toggler.sidebar-toggler(href='#', @click='sidebarToggle') &#9776;
      li.nav-item.px-1
        a.nav-link(href='/dashboard') Dashboard
      li.nav-item.px-1
        a.nav-link(href='/services') Services
      li.nav-item.px-1
        a.nav-link(href='/logs') Logs
</template>
<script>
  import navbar from './navbar';

  export default {
    name: 'AppHeader',
    components: {
        navbar,
    },
    methods: {
        click () {

        },
        sidebarToggle (e) {
            e.preventDefault();
            document.body.classList.toggle('sidebar-hidden')
        },
        mobileSidebarToggle (e) {
          e.preventDefault();
          document.body.classList.toggle('sidebar-mobile-show')
        },
        asideToggle (e) {
            e.preventDefault();
            document.body.classList.toggle('aside-menu-hidden')
        }
    }
  }
</script>
<style lang="scss">

</style>
