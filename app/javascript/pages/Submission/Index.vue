<template>

  <Head title="Submissions" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto mt-8">
    <div class="flex flex-row justify-between items-center relative">
      <h1 class="text-4xl font-black mb-4">Submissions</h1>
      <div class="absolute shadow border rounded border-slate-300 left-1/3 w-1/3">
        <multiselect placeholder="Filter submissions by tags..." :max-height="150" track-by="name" :multiple="true"
          label="name" v-model="filters" :options="tags" :searchable="true">
          <template #selection="{ values, search, isOpen }">
            <div class="pb-2 flex flex-row gap-2 ">
              <span class="text-nowrap text-sm px-4 py-2 rounded border border-slate-200 bg-slate-100"
                v-for="value in values">{{
                  value.name }}</span>
            </div>
          </template>
        </multiselect>
      </div>
      <div class="text-end">
        <Link class="px-4 py-2 rounded bg-indigo-500 text-white border border-indigo-900 hover:bg-indigo-800 transition"
          href="/submissions/new">New submission</Link>
      </div>
    </div>

    <div class="grid grid-cols-3 gap-4 mt-8">
      <Link
        class="hover:bg-slate-100 transition hover:border-indigo-600 bg-white shadow hover:shadow-lg rounded border border-slate-300"
        :href="`/submissions/${submission.id}`" v-for="submission in submissions.filter(submissionHasTag)"
        :key="submission.id">
      <div class="text-xl row-span-1 p-8 pb-4 flex flex-col gap-4 justify-between h-full">
        <div class="col-span-2 flex flex-wrap flex-row gap-2" v-if="submission.tags">
          <a
            class="text-slate-700 text-nowrap text-xs border border-slate-300 bg-slate-100 rounded px-2 py-1"
            v-for="tag in submission.tags" :key="tag">{{ tag.name }}</a>
        </div>
        <h3>{{ submission.title }}</h3>
        <div class="flex flex-row justify-between items-center">
          <p class="text-sm text-slate-400 text-italic">Created {{ formatDistance(submission.updated_at, new Date(), {
            addSuffix: true
          }) }}</p>
          <div class="text-sm flex flex-row justify-end items-center">
            <Link :href="`/submissions/${submission.id}/edit`"
              class="rounded text-slate-800 hover:bg-indigo-200 transition px-4 py-2">
            Edit
            </Link>
            <Link :href="`/submissions/${submission.id}`"
              class="rounded text-rose-800 hover:bg-rose-200 transition px-4 py-2" as="button" method="delete">
            Delete
            </Link>
          </div>
        </div>
      </div>
      </Link>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import { ref, reactive } from 'vue'
import Submission from './Submission.vue'
import { SubmissionType } from './types'
import { formatDistance } from 'date-fns';
import Multiselect from 'vue-multiselect';
import "vue-multiselect/dist/vue-multiselect.min.css";

const { submissions, flash, tags } = defineProps<{
  submissions: SubmissionType[],
  tags: Array,
  flash: { notice?: string }
}>()

let filters = ref([]);

function submissionHasTag(submission) {
  if (!filters.value.length) { return true; }

  for (const tag of filters.value) {
    const submission_tags = submission.tags.map(tag => tag.name);
    if (submission_tags.includes(tag.name)) { return true; }
  }
  return false;
}
</script>

<style>
.notice {
  color: green;
}
</style>
