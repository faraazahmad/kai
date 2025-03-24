<template>
  <Head :title="`Note #${note.id}`" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <h1>Note #{{ note.id }}</h1>

  <Note :note="note" />

  <div>
    <Link :href="`/notes/${note.id}/edit`">Edit this note</Link> |
    <Link href="/notes">Back to notes</Link>

    <br />

    <Link
      :href="`/notes/${note.id}`"
      as="button"
      method="delete"
    >
      Destroy this note
    </Link>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Note from './Note.vue'
import { NoteType } from './types'

const { note, flash } = defineProps<{
  note: NoteType
  flash: { notice?: string }
}>()
</script>

<style scoped>
.notice {
  color: green;
}
</style>
