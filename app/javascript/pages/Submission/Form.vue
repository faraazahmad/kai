<template>
  <form @submit.prevent="emit('onSubmit', form)" class="flex flex-col gap-4">
    <div>
      <label class="label" for="title">Title</label>
      <input class="px-4 py-2 rounded shadow border border-slate-400 w-full" type="text" name="title" id="title" v-model="form.title" />
      <div v-if="form.errors.title" class="error">
        {{ form.errors.title }}
      </div>
    </div>
    <div>
      <label class="label" for="url">URL</label>
      <input class="px-4 py-2 rounded shadow border border-slate-400 w-full" type="url" name="url" id="url" v-model="form.url" />
      <div v-if="form.errors.url" class="error">
        {{ form.errors.url }}
      </div>
    </div>
    <div>
      <button class="bg-green-600 border text-white transition px-4 py-2 rounded shadow border-green-800 hover:bg-green-700" type="submit" :disabled="form.processing">
        {{ submitText }}
      </button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { InertiaForm, useForm } from '@inertiajs/vue3'
import { SubmissionFormType, SubmissionType } from './types'

const { submission, submitText } = defineProps<{
  submission: SubmissionType
  submitText: string
}>()

const emit = defineEmits<{
  onSubmit: [form: InertiaForm<SubmissionFormType>]
}>()

const form = useForm<SubmissionFormType>({
  title: submission.title,
  url: submission.url,
  user_id: submission.user_id,
  content: submission.content,
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
