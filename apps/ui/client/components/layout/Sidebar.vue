<template lang="pug">
  aside.menu.app-sidebar
    p.menu-label General
    ul.menu-list
      li
        router-link(to="/dashboard")
          i.fa.fa-dashboard
          |  Dashboard
      li
        router-link(to="/services")
          i.fa.fa-tasks
          |  Services
      li
        router-link(to="/logs")
          i.fa.fa-folder-open
          |  Logs
    p.menu-label Administration
</template>
<script>
  export default {
    name: 'Sidebar'
  };
</script>
<style lang="scss">
  .app-sidebar{
    position: fixed;
    top: 50px;
    left: 0;
    bottom: 0;
    padding: 20px 0 50px;
    width: 180px;
    background-color: #383e4b;

    .menu-list {
      color: #fff;
    }
  }
</style>
