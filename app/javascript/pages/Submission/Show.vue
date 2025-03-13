<template>
  <Head :title="`Submission #${submission.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto flex flex-col gap-8">
    <div class="flex flex-row items-center justify-between">
      <div>
        <Link href="/submissions"><h2 class="text-sm">Submissions</h2></Link>
        <h1 class="text-2xl font-black">{{ submission.title }}</h1>
      </div>

      <div class="flex flex-row gap-4">
        <Link class="bg-white rounded shadow border border-slate-200 hover:bg-slate-50 transition px-4 py-2" :href="`/submissions/${submission.id}/edit`">Edit</Link>
        <Link
          :href="`/submissions/${submission.id}`"
          class="bg-rose-100 rounded shadow border border-rose-200 text-rose-800 hover:bg-slate-50 transition px-4 py-2"
          as="button"
          method="delete"
        >
          Delete
        </Link>
      </div>
    </div>

    <div class="grid grid-cols-5 gap-8">
      <iframe class="col-span-3 rounded shadow w-full h-150" :src="getYtEmbedLink(submission)" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen v-if="submission.submission_type === 'youtube'"></iframe>
      <iframe class="rounded shadow col-span-3 w-full h-screen" :src="submission.url" v-else></iframe>
      <div class="col-span-2 bg-white border border-slate-200 shadow p-4 rounded">
        Hello there
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import { computed } from 'vue';
import Submission from './Submission.vue'
import { SubmissionType } from './types'

const { submission, flash } = defineProps<{
  submission: SubmissionType
  flash: { notice?: string }
}>()

function getYtEmbedLink(submission) {
  const urlObj = new URL(submission.url)
  const videoId = urlObj.searchParams.get('v')
  const embedVideoId = `https://www.youtube-nocookie.com/embed/${videoId}`;

  return embedVideoId;
}

const pdfPages = computed(() => {
  return JSON.parse(submission.content).pages
})

</script>

<style scoped>
.notice {
  color: green;
}
</style>
