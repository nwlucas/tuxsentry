<template lang="pug">
  .animated.fadeIn
    .row
      .col-sm-6.col-lg-3
        .card.card-inverse.card-primary
          .card-block.pb-0
            h4.mb-0 CPU
      .col-sm-6.col-lg-3
        .card.card-inverse.card-info
          .card-block.pb-0
            h4.mb-0 Memory
      .col-sm-6.col-lg-3
        .card.card-inverse.card-info
          .card-block.pb-0
            h4.mb-0 Placeholder
      .col-sm-6.col-lg-3
        .card.card-inverse.card-info
          .card-block.pb-0
            h4.mb-0 Placeholder

    .card
      .card-block
        .row
          .col-sm-5
            h4.card-title.mb-0 Statistics
</template>
<script>
  export default {
    name: 'Dashboard'

  }
</script>
<style lang="scss">

</style>
