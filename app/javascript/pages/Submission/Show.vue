<template>
  <Head :title="`Submission #${submission.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <h1>Submission #{{ submission.id }}</h1>

  <Submission :submission="submission" />

  <div>
    <Link :href="`/submissions/${submission.id}/edit`">Edit this submission</Link> |
    <Link href="/submissions">Back to submissions</Link>

    <br />

    <Link
      :href="`/submissions/${submission.id}`"
      as="button"
      method="delete"
    >
      Destroy this submission
    </Link>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Submission from './Submission.vue'
import { SubmissionType } from './types'

const { submission, flash } = defineProps<{
  submission: SubmissionType
  flash: { notice?: string }
}>()
</script>

<style scoped>
.notice {
  color: green;
}
</style>
