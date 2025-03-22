<template>
  <Head title="New submission" />

  <h1>New submission</h1>

  <Form
    :submission="submission"
    submitText="Create Submission"
    @onSubmit="handleSubmit"
  />

  <br />

  <div>
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
  form.post('/submissions')
}
</script>
