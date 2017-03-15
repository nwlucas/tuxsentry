<template lang="pug">
  header.app-header.navbar
    slot
</template>
<script>
  export default {
    name: 'navbar',
    created () {
      this._navbar = true
    }
  }
</script>
<style lang="scss">

</style>
