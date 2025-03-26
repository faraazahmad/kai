<template>
  <Head title="New note" />

  <h1>New note</h1>

  <Form
    :note="note"
    submitText="Create Note"
    @onSubmit="handleSubmit"
  />

  <br />

  <div>
    <Link href="/notes">Back to notes</Link>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Form from './Form.vue'
import { NoteFormType, NoteType } from './types'

const { note } = defineProps<{ note: NoteType }>()

const handleSubmit = (form: InertiaForm<NoteFormType>) => {
  form.transform((data) => ({ note: data }))
  form.post('/notes')
}
</script>
