<template>
  <div id="#container">
    <header>
      <nav>
        <ul>
          <li>Dashboard</li>
          <li>Logs</li>
          <li>System</li>
        </ul>
      </nav>
    </header>
    <main>
      <router-view></router-view>
    </main>
    <footer> Copyright Info.
    </footer>
  </div><!-- container -->
</template>
<script>
  export default {
    components: {

    }
  };
</script>
<style lang="stylus">

</style>
