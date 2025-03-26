<template>

  <Head title="New submission" />

  <div class="flex flex-row items-center min-h-screen bg-slate-100">
    <div class="container mx-auto bg-white w-1/2 rounded p-8 shadow border border-slate-300">

      <h1 class="text-4xl mb-8">
        <Link href="/submissions" class="transition hover:text-indigo-500 font-thin">Submissions</Link> / 
        <span class="font-black">New submission</span>
      </h1>

      <Form :submission="submission" submitText="Submit" @onSubmit="handleSubmit" />
    </div>
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
