<template>
  <Head title="Submissions" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <h1>Submissions</h1>

  <div>
    <div v-for="submission in submissions" :key="submission.id">
      <Submission :submission="submission" />
      <p>
        <Link :href="`/submissions/${submission.id}`">Show this submission</Link>
      </p>
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
