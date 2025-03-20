<template>
  <div id="page-markdown" class="mb-8 rounded bg-white shadow border border-slate-200 px-16 py-8">
    <vue-markdown :source="page.markdown" />
  </div>
</template>

<script setup lang="ts">
import VueMarkdown from 'vue-markdown-render'

const { page } = defineProps<{
  page: Object
}>()
</script>

<style lang="css">
</style>
