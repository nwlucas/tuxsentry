<template lang="pug">
  ol.breadcrumb
    li.breadcrumb-item(v-for="(item, index) in list")
      span.active(v-if="isLast(index)") {{ showName(item) }}
      router-link(v-bind:to="item.path", v-else) {{ showName(item) }}
</template>
<script>
  export default {
    props: {
      list: {
          type: Array,
          required: true,
          default: () => []
      },
      separator: String
    },
    methods: {
      isLast (index) {
        return index === this.list.length - 1
      },
      showName (item) {
        return item.meta && item.meta.label || item.name
      }
    }

  }
</script>
<style lang="scss">

</style>
