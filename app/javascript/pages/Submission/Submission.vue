<template>
  <div>
    <p>
      <strong>Title:</strong>
      {{ submission.title }}
    </p>
    <p>
      <strong>Url:</strong>
      {{ submission.url }}
    </p>
    <p>
      <strong>User:</strong>
      {{ submission.user_id }}
    </p>
    <p>
      <strong>Content:</strong>
      {{ submission.content }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { SubmissionType } from './types'

const { submission } = defineProps<{ submission: SubmissionType }>()
</script>
