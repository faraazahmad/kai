<template>
  <Head title="Submissions" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <div class="container mx-auto mt-8">
    <h1 class="text-4xl font-black mb-4">Submissions</h1>

    <div class="grid grid-cols-4 gap-2" >
      <Link class="hover:bg-slate-100 transition hover:border-indigo-600 px-8 py-4 bg-white shadow rounded border border-slate-200 px-4 py-2" :href="`/submissions/${submission.id}`" v-for="submission in submissions" :key="submission.id">
        {{ submission.title }}
      </Link>
    </div>

    <Link href="/submissions/new">New submission</Link>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Submission from './Submission.vue'
import { SubmissionType } from './types'

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
