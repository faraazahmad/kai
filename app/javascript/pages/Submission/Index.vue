<template>
  <Head title="Submissions" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <h1 class="text-2xl font-black mb-4">Submissions</h1>

  <div>
    <div class="grid grid-cols-4 gap-2" v-for="submission in submissions" :key="submission.id">
      <Link :href="`/submissions/${submission.id}`">
        <div class="bg-white shadow rounded border border-slate-200 px-4 py-2">
          {{ submission.title }}
        </div>
      </Link>
    </div>
  </div>

  <Link href="/submissions/new">New submission</Link>
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
