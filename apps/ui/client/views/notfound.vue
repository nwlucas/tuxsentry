<template lang="pug">
  .not-found
    .nprogress-container
    .page.jumbotron
      .text
        h1 404
        p Sorry, we couldn't find the page you were looking for.
        router-link(to="/dashboard")
          span.fa.fa-home Take me Home
</template>
<script>
  export default {
    name: 'NotFound'
  };
</script>
<style lang="scss">
</style>
