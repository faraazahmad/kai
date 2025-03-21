<template>
  <Head :title="`Submission #${submission.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto flex flex-col gap-8 mt-8">
    <div class="flex flex-row items-center justify-between">
      <div>
        <Link href="/submissions"><h2 class="text-md">Submissions</h2></Link>
        <h1 class="text-3xl font-black">{{ submission.title }}</h1>
      </div>

      <div class="flex flex-row gap-4">
        <Link class="bg-white rounded shadow border border-slate-300 hover:bg-slate-200 transition px-4 py-2" :href="`/submissions/${submission.id}/edit`">Edit</Link>
        <Link
          :href="`/submissions/${submission.id}`"
          class="bg-rose-100 rounded shadow border border-rose-300 text-rose-800 hover:bg-rose-200 transition px-4 py-2"
          as="button"
          method="delete"
        >
          Delete
        </Link>
      </div>
    </div>

    <div class="grid grid-cols-5 gap-8">
      <iframe class="col-span-3 rounded shadow w-full h-150" :src="`${getYoutubeEmbedURL(submission)}?start=${videoStart}&autoplay=${autoplay}`" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen v-if="submission.submission_type === 'youtube'"></iframe>
      <!-- <iframe class="rounded shadow col-span-3 w-full h-screen" :src="submission.url" v-else></iframe> -->
      <div class="rounded shadow col-span-3 w-full h-screen" v-else>
        <PdfPage :page="2" :binary="pdf_binary" :submission="submission" />
      </div>
      <div id="content" class="h-150 overflow-y-auto col-span-2 bg-white border border-slate-300 shadow p-8 rounded flex flex-col gap-4">
        <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'youtube'">Top 10 highlights from video:</h2>
        <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'pdf'">Top 15 highlights from PDF:</h2>
        <div @click="() => setVideoStartTime(point)" v-for="point in parsedSubmission(submission)" class="cursor-pointer border border-slate-200 rounded bg-slate-50 px-8 py-4 hover:bg-indigo-100 hover:border-indigo-600 transition hover:shadow">
          {{point['text']}}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import { ref, computed } from 'vue';
import Submission from './Submission.vue'
import { SubmissionType } from './types'
import PdfPage from './PdfPage.vue';
import { parse } from 'yaml';

let videoStart = ref(0);
let autoplay = ref(0);

const { submission, flash, pdf_binary } = defineProps<{
  submission: SubmissionType
  pdf_binary: String,
  flash: { notice?: string }
}>()

function setVideoStartTime(point) {
  videoStart.value = Math.round(point['start']);
  autoplay.value = 1;
}

function getYoutubeEmbedURL(submission) {
  const urlObj = new URL(submission.url)
  const videoId = urlObj.searchParams.get('v')
  const embedVideoId = `https://www.youtube-nocookie.com/embed/${videoId}`;

  return embedVideoId;
}

function parsedSubmission(submission) {
  return parse(submission.content);
}

</script>

<style>
</style>
