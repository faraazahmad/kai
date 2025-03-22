<template>
  <Head title="Submissions" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto mt-8">
    <div class="flex flex-row justify-between items-center">
      <h1 class="text-4xl font-black mb-4">Submissions</h1>
      <Link class="px-4 py-2 rounded bg-indigo-500 text-white border border-indigo-900 hover:bg-indigo-800 transition" href="/submissions/new">New submission</Link>
    </div>

    <div class="grid grid-cols-4 gap-4 mt-8">
      <Link class="grid grid-rows-4 hover:bg-slate-100 transition hover:border-indigo-600 bg-white shadow hover:shadow-lg rounded border border-slate-300" :href="`/submissions/${submission.id}`" v-for="submission in submissions" :key="submission.id">
        <div class="row-span-1 border-b border-slate-300 px-8 py-4 flex flex-row gap-2 justify-end">
          <Link
            :href="`/submissions/${submission.id}/edit`"
            class="rounded text-slate-800 hover:bg-indigo-200 transition px-4 py-2"
          >
            Edit
          </Link>
          <Link
            :href="`/submissions/${submission.id}`"
            class="rounded text-rose-800 hover:bg-rose-200 transition px-4 py-2"
            as="button"
            method="delete"
          >
            Delete
          </Link>
        </div>
        <div class="text-xl row-span-3 px-8 py-4 flex flex-col">
          <p class="text-sm text-slate-400 text-italic">Created {{ formatDistance(submission.updated_at, new Date(), { addSuffix: true }) }}</p>
          <h3>{{ submission.title }}</h3>
        </div>
      </Link>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Submission from './Submission.vue'
import { SubmissionType } from './types'
import { formatDistance } from 'date-fns';

const { submissions, flash } = defineProps<{
  submissions: SubmissionType[]
  flash: { notice?: string }
}>()
</script>

<style scoped>
.notice {
  color: green;
}
</style>
