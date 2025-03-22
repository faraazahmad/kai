<template>
  <div id="page-markdown" class="w-full mb-8 rounded bg-white shadow border border-slate-200">
    <div class="shadow rounded-t border border-slate-300 bg-slate-100 px-8 py-4 flex flex-row justify-between w-full items-center">
      <div class="">
        Page : {{ page + 1 }}
      </div>
      <!-- <a class="text-indigo-500 font-medium px-4 py-2 hover:bg-indigo-100 transition rounded" :href="getPdfPath(submission.title)" download>Open in Reader</a> -->
      <button class="text-indigo-500 font-medium px-4 py-2 hover:bg-indigo-100 transition rounded" @click="openPdfInReader(submission.title)">Open in Reader</button>
    </div>
    <div class="h-screen overflow-y-auto ">
      <VuePdfEmbed annotation-layer text-layer :page="page" :showAllPages="false" :source="`data:application/pdf;base64,${binary}`"></VuePdfEmbed>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { router, usePage } from '@inertiajs/vue3'

const currentPage = usePage()

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

function openPdfInReader(title: String) {
  const path = `~/.kai/pdfs/${title.split(' ').join('_').toLowerCase()}.pdf`
  router.get(`/submissions/${submission.id}/open-pdf`);
}

function getPdfPath(title: String) {
  const rootPath = "file://\\\\wsl.localhost\\Ubuntu-24.04\\home\\faraaz\\.kai\\pdfs"
  const path = `${rootPath}/${title.split(' ').join('_').toLowerCase()}.pdf`

  return path;
}
</script>

<style lang="css">
</style>
