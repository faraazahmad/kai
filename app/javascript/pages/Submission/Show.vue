<template>

  <Head :title="`Submission #${submission.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="bg-orange-100 min-h-screen">
    <div class="container mx-auto h-full bg-orange-100 flex flex-col gap-8 pt-8">
      <div class="flex flex-row items-start justify-between">
        <div class="flex flex-col gap-0">
          <h1 class="text-3xl font-thin w-full flex flex-row items-center gap-4">
            <Link class="hover:text-orange-600 transition" href="/submissions">Submissions</Link> /
            <span class="text-4xl text-slate-800 font-dm-serif">{{ submission.title }}</span>
          </h1>
          <div class="mt-4 flex flex-row gap-4" v-if="tags">
            <a class="text-sm bg-white rounded-lg px-4 py-2" v-for="tag in tags"
              :key="tag">{{ tag.name }}</a>
          </div>
        </div>

        <div class="flex flex-row gap-4 justify-end flex-grow">
          <Link class="bg-white rounded-lg shadow border border-slate-500 hover:bg-slate-200 transition px-4 py-2"
            :href="`/submissions/${submission.id}/edit`">Edit</Link>
          <Link :href="`/submissions/${submission.id}/process`"
            class="bg-white rounded-lg shadow border border-slate-500 hover:bg-slate-200 transition px-4 py-2"
            as="button" method="post">
          Re-process
          </Link>
          <button
            class="bg-white rounded-lg shadow border border-slate-500 hover:bg-slate-200 transition px-4 py-2"
            @click="toggleNewNoteDialog">
            New note
          </button>
          <Link :href="`/submissions/${submission.id}`"
            class="bg-rose-100 rounded-lg shadow border border-rose-300 text-rose-800 hover:bg-rose-200 transition px-4 py-2"
            as="button" method="delete">
          Delete
          </Link>
        </div>
      </div>

      <div class="grid grid-cols-5 gap-8" v-if="submission.status === 'Processed'">
        <iframe class="col-span-3 rounded shadow w-full h-150"
          :src="`${getYoutubeEmbedURL(submission)}?start=${videoStart}&autoplay=${autoplay}`"
          title="YouTube video player" frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
          referrerpolicy="strict-origin-when-cross-origin" allowfullscreen
          v-if="submission.submission_type === 'youtube'"></iframe>
        <div class="rounded shadow col-span-3 w-full h-screen" v-else>
          <PdfPage :page="pdfPage" :binary="pdf_binary" :submission="submission" />
        </div>
        <div id="content" class="flex flex-col gap-4 col-span-2">
          <div class="w-full bg-white/25 backdrop-blur-xs top-0 left-0 mx-auto" v-if="newNoteDialogOpen">
            <div class="flex flex-col gap-2 bg-white shadow-lg rounded-lg p-8 border border-slate-500">
              <div class="flex flex-row justify-between items-center">
                <h3 class="text-lg w-full text-slate-900">New note</h3>
                <button class="px-6 py-2 rounded border-none text-xl hover:bg-slate-300 transition"
                  @click="toggleNewNoteDialog">
                  x
                </button>
              </div>
              <Form :note="newNoteData" submitText="Add Note" @onSubmit="handleSubmit" />
            </div>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <button
              :class="`${currentTab === 'points' ? 'bg-orange-200 border-orange-400 hover:bg-orange-200' : 'bg-white border-slate-500 hover:bg-slate-100'} col-span-1 border transition py-4 rounded-lg `"
              @click="currentTab = 'points'">Points</button>
            <button
              :class="`${currentTab === 'notes' ? 'bg-orange-200 border-orange-400 hover:bg-orange-200' : 'bg-white border-slate-500 hover:bg-slate-100'} col-span-1 border transition py-4 rounded-lg `"
              @click="currentTab = 'notes'">Notes</button>
          </div>
          <div
            class="h-150 overflow-y-auto col-span-2 bg-white border border-slate-300 shadow p-8 rounded-lg flex flex-col gap-4"
            v-if="currentTab === 'points'">
            <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'youtube'">Top 10
              highlights from the video:</h2>
            <h2 class="font-black text-xl text-slate-800 mb-4" v-if="submission.submission_type === 'pdf'">15 key points
              from the PDF:</h2>
            <div @click="() => setVideoStartTime(point)" v-for="point in parsedSubmission(submission)"
              class="cursor-pointer border border-slate-200 rounded-lg bg-slate-200 px-8 py-4 hover:border-slate-500 transition hover:shadow">
              {{ point['text'] }}
            </div>
          </div>
          <div
            class="h-150 overflow-y-auto col-span-2 bg-white border border-slate-300 shadow p-8 rounded flex flex-col gap-4"
            v-else-if="currentTab === 'notes'">
            <h2 class="font-black text-xl text-slate-800 mb-4">Notes</h2>
            <div v-for="note in notes" class="note border border-slate-200 rounded bg-slate-200 px-8 py-4 relative">
              {{ note['content'] }}
              <Link :href="`/notes/${note.id}`"
                class="note-delete-button bg-rose-100 rounded shadow border border-rose-300 text-rose-800 hover:bg-rose-200 px-4 py-2 absolute -top-2 -right-4"
                as="button" method="delete">
              Delete
              </Link>
            </div>
          </div>
        </div>
      </div>

      <div
        class="w-full text-white rounded-lg font-dm-serif text-4xl border border-emerald-900 shadow-lg bg-radial-[at_25%_25%] from-emerald-700 to-green-700 to-75% px-16 py-24 flex flex-row items-center"
        v-else-if="submission.status === 'Processing'">
        <span class="animate-pulse">Processing...</span>
      </div>
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

<style scoped>
.note .note-delete-button {
  display: none;
  opacity: 0;
}

.note:hover .note-delete-button {
  display: inline;
  opacity: 1;
}
</style>
