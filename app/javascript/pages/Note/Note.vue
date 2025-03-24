<template>
  <div>
    <p>
      <strong>Content:</strong>
      {{ note.content }}
    </p>
    <p>
      <strong>User:</strong>
      {{ note.user_id }}
    </p>
    <p>
      <strong>Submission:</strong>
      {{ note.submission_id }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { NoteType } from './types'

const { note } = defineProps<{ note: NoteType }>()
</script>
