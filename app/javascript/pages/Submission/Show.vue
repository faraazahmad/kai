<template>

  <Head :title="`Submission #${submission.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto flex flex-col gap-8 mt-8">
    <div class="flex flex-row items-center justify-between">
      <div class="flex flex-col gap-0">
        <h1 class="text-4xl font-thin w-full">
          <Link class="hover:text-indigo-600 transition" href="/submissions">Submissions</Link> /
          <span class="font-black">{{ submission.title }}</span>
        </h1>
        <div class="mt-4 flex flex-row gap-4" v-if="tags">
          <Link
            class="text-sm hover:bg-slate-200 transition border border-slate-300 bg-slate-100 rounded-full px-4 py-2"
            v-for="tag in tags" :key="tag">{{ tag.name }}</Link>
        </div>
      </div>

      <div class="flex flex-row gap-4 justify-end flex-grow">
        <Link class="bg-white rounded shadow border border-slate-300 hover:bg-slate-200 transition px-4 py-2"
          :href="`/submissions/${submission.id}/edit`">Edit</Link>
        <Link :href="`/submissions/${submission.id}/process`"
          class="bg-emerald-100 rounded shadow border border-emerald-300 text-emerald-800 hover:bg-emerald-200 transition px-4 py-2"
          as="button" method="post">
        Re-process
        </Link>
        <button
          class="bg-blue-100 rounded shadow border border-blue-300 text-blue-800 hover:bg-blue-200 transition px-4 py-2"
          @click="toggleNewNoteDialog">
          New Note
        </button>
        <Link :href="`/submissions/${submission.id}`"
          class="bg-rose-100 rounded shadow border border-rose-300 text-rose-800 hover:bg-rose-200 transition px-4 py-2"
          as="button" method="delete">
        Delete
        </Link>
      </div>
    </div>

    <div class="grid grid-cols-5 gap-8" v-if="submission.status === 'Processed'">
      <iframe class="col-span-3 rounded shadow w-full h-150"
        :src="`${getYoutubeEmbedURL(submission)}?start=${videoStart}&autoplay=${autoplay}`" title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
        referrerpolicy="strict-origin-when-cross-origin" allowfullscreen
        v-if="submission.submission_type === 'youtube'"></iframe>
      <div class="rounded shadow col-span-3 w-full h-screen" v-else>
        <PdfPage :page="pdfPage" :binary="pdf_binary" :submission="submission" />
      </div>
      <div id="content" class="flex flex-col gap-4 col-span-2 bg-white">
        <div class="w-full bg-white/25 backdrop-blur-xs top-0 left-0 mx-auto" v-if="newNoteDialogOpen">
          <div class="flex flex-col gap-2 bg-amber-200 shadow-lg rounded-lg p-8 border border-amber-300">
            <div class="flex flex-row justify-between items-center">
              <h3 class="text-lg w-full text-amber-900/75">New note</h3>
              <button class="px-6 py-2 rounded border-none text-xl hover:bg-amber-300 transition"
                @click="toggleNewNoteDialog">
                x
              </button>
            </div>
            <Form :note="newNoteData" submitText="Add Note" @onSubmit="handleSubmit" />
          </div>
        </div>
        <div class="grid grid-cols-2 gap-4">
          <button
            :class="`${currentTab === 'points' ? 'bg-indigo-100 hover:bg-indigo-200' : 'hover:bg-slate-100'} col-span-1 border border-indigo-300 transition py-4 rounded-lg `"
            @click="currentTab = 'points'">Points</button>
          <button
            :class="`${currentTab === 'notes' ? 'bg-indigo-100 hover:bg-indigo-200' : 'hover:bg-slate-100'} col-span-1 border border-indigo-300 transition py-4 rounded-lg `"
            @click="currentTab = 'notes'">Notes</button>
        </div>
        <div
          class="h-150 overflow-y-auto col-span-2 bg-white border border-slate-300 shadow p-8 rounded flex flex-col gap-4"
          v-if="currentTab === 'points'">
          <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'youtube'">Top 10
            highlights from the video:</h2>
          <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'pdf'">15 key points
            from the PDF:</h2>
          <div @click="() => setVideoStartTime(point)" v-for="point in parsedSubmission(submission)"
            class="cursor-pointer border border-slate-200 rounded bg-slate-50 px-8 py-4 hover:bg-indigo-100 hover:border-indigo-600 transition hover:shadow">
            {{ point['text'] }}
          </div>
        </div>
        <div
          class="h-150 overflow-y-auto col-span-2 bg-white border border-slate-300 shadow p-8 rounded flex flex-col gap-4"
          v-else-if="currentTab === 'notes'">
          <h2 class="font-black text-xl text-slate-800 mb-4">Notes</h2>
          <div v-for="note in notes"
            class="border border-slate-200 rounded bg-slate-50 px-8 py-4">
            {{ note['content'] }}
          </div>
        </div>
      </div>
    </div>

    <div
      class="w-full rounded border border-emerald-500 bg-radial-[at_25%_25%] from-emerald-100 to-green-200 to-75% px-16 py-8 flex flex-row items-center"
      v-else-if="submission.status === 'Processing'">
      Processing
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Submission from './Submission.vue'
import { SubmissionType } from './types'
import PdfPage from './PdfPage.vue';
import Form from '../Note/Form.vue'
import { NoteFormType, NoteType } from '../Note/types'
import { ref, computed } from 'vue';
import { parse } from 'yaml';

const { submission, flash, pdf_binary, tags, user, notes } = defineProps<{
  submission: SubmissionType,
  notes: NoteType[],
  pdf_binary: String,
  tags: Array,
  user: Object,
  flash: { notice?: string }
}>()

let currentTab = ref('points');
let videoStart = ref(0);
let autoplay = ref(0);
let pdfPage = ref(0);
let newNoteDialogOpen = ref(false);
let newNoteData = ref({
  submission_id: submission.id,
  user_id: user.id
} as NoteType);

function toggleNewNoteDialog() {
  newNoteData.value = { submission_id: submission.id, user_id: user.id } as NoteType;
  newNoteDialogOpen.value = !newNoteDialogOpen.value;
}

const handleSubmit = (form: InertiaForm<NoteFormType>) => {
  form.transform((data) => ({ note: data }))
  form.post('/notes');
  toggleNewNoteDialog();
}

function setVideoStartTime(point) {
  if (submission.submission_type === 'youtube') {
    videoStart.value = Math.round(point['start']);
    autoplay.value = 1;
  } else if (submission.submission_type === 'pdf') {
    pdfPage.value = point['page'];
  }
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

<style></style>
