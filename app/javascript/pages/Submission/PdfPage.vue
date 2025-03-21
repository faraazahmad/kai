<template>
  <div id="page-markdown" class="w-full mb-8 rounded bg-white shadow border border-slate-200">
    <VuePdfEmbed :page="page" :showAllPages="false" :source="`data:application/pdf;base64,${binary}`"></VuePdfEmbed>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import VuePdfEmbed from 'vue-pdf-embed'

// optional styles
import 'vue-pdf-embed/dist/styles/annotationLayer.css'
import 'vue-pdf-embed/dist/styles/textLayer.css'
import { SubmissionType } from './types';

const { submission, binary, page } = defineProps<{
  submission: SubmissionType,
  binary: String,
  page: Number
}>();

const getPdfName = (title) => {
  const rootPath = "file://\\\\wsl.localhost\\Ubuntu-24.04\\home\\faraaz\\.kai\\pdfs"
  const path = `${rootPath}/${title.split(' ').join('_').toLowerCase()}.pdf`

  return path;
}
</script>

<style lang="css">
</style>
