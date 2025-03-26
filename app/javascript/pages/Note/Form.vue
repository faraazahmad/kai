<template>
  <form class="flex flex-col gap-4" @submit.prevent="emit('onSubmit', form)">
    <div>
      <textarea placeholder="Add note content here..." class="bg-transparent border-none w-full rounded h-48" name="content" id="content" v-model="form.content" />
      <div v-if="form.errors.content" class="error">
        {{ form.errors.content }}
      </div>
    </div>
    <div>
      <button class="px-4 py-2 rounded bg-amber-400 text-black border border-amber-500 hover:bg-amber-600/60 transition w-full" type="submit" :disabled="form.processing">
        {{ submitText }}
      </button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { InertiaForm, useForm } from '@inertiajs/vue3'
import { NoteFormType, NoteType } from './types'

const { note, submitText } = defineProps<{
  note: NoteType
  submitText: string
}>()

const emit = defineEmits<{
  onSubmit: [form: InertiaForm<NoteFormType>]
}>()

const form = useForm<NoteFormType>({
  content: note.content,
  user_id: note.user_id,
  submission_id: note.submission_id,
})
</script>

<style scoped>
.label {
  display: block;
}
.error {
  color: red;
}
</style>
