<template>
  <Head title="Editing note" />

  <h1>Editing note</h1>

  <Form
    :note="note"
    submitText="Update Note"
    @onSubmit="handleSubmit"
  />

  <br />

  <div>
    <Link :href="`/notes/${note.id}`">Show this note</Link> |
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
  form.patch(`/notes/${note.id}`)
}
</script>
