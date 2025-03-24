<template>
  <Head title="Notes" />

  <p v-if="flash.notice" class="notice">{{ flash.notice }}</p>

  <h1>Notes</h1>

  <div>
    <div v-for="note in notes" :key="note.id">
      <Note :note="note" />
      <p>
        <Link :href="`/notes/${note.id}`">Show this note</Link>
      </p>
    </div>
  </div>

  <Link href="/notes/new">New note</Link>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Note from './Note.vue'
import { NoteType } from './types'

const { notes, flash } = defineProps<{
  notes: NoteType[]
  flash: { notice?: string }
}>()
</script>

<style scoped>
.notice {
  color: green;
}
</style>
