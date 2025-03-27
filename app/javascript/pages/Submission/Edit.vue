<template>

  <Head title="Editing submission" />

  <div class="flex flex-row items-center min-h-screen bg-orange-100">
    <div class="container mx-auto w-1/2">
      <Link class="px-4 py-2 bg-white border border-slate-300 inline-block mb-4 hover:bg-slate-100 transition rounded shadow"
        :href="`/submissions/${submission.id}`">Cancel</Link>
      <div class="bg-white rounded p-8 shadow border border-slate-300">

        <h1 class="text-3xl mb-8">
          <Link href="/submissions" class="transition hover:text-orange-500 font-thin">Submissions</Link> /
          <span class="text-4xl font-dm-serif">Edit</span>
        </h1>

        <Form :submission="submission" submitText="Save" @onSubmit="handleSubmit" />
      </div>
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
  form.patch(`/submissions/${submission.id}`)
}
</script>
