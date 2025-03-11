<template>
  <Head title="Editing submission" />

  <h1>Editing submission</h1>

  <Form
    :submission="submission"
    submitText="Update Submission"
    @onSubmit="handleSubmit"
  />

  <br />

  <div>
    <Link :href="`/submissions/${submission.id}`">Show this submission</Link> |
    <Link href="/submissions">Back to submissions</Link>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Form from './Form.vue'
import { SubmissionFormType, SubmissionType } from './types'

const { submission } = defineProps<{ submission: SubmissionType }>()

const handleSubmit = (form: InertiaForm<SubmissionFormType>) => {
  form.transform((data) => ({ submission: data }))
  form.patch(`/submissions/${submission.id}`)
}
</script>
