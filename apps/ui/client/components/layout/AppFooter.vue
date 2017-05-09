<template lang="pug">
  footer.footer
    .columns
      .column.is-one-quarter
        p &copy;2017
          = " "
          a(href="https://www.dtlr.com") DTLR
      .column
        p Powered by
         = " "
         a(href='mailto://helpdesk@dtlr.com') DTLR IT
</template>
<script>
  export default {
    name: 'AppFooter'
  };
</script>
<style lang="scss">
  .footer {
    margin-left: 180px;
  }
</style>
