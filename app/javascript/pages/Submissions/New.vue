<template>

  <Head title="Inertia + Vite Ruby + Vue Example" />

  <div>
    <Navbar :user="user" />
    <div class="pt-8 container mx-auto">
      <form @submit.prevent="form.post(props.path)">
        <div class="flex flex-col gap-4">
          <div class="flex flex-col">
            <label for="title">Title:</label>
            <input id="title" v-model="form.title" />
          </div>

          <div class="flex flex-col">
            <label for="url">URL:</label>
            <input id="url" type="url" v-model="form.url" />
          </div>

          <button class="px-8 py-4 shadow bg-blue-500 rounded text-white hover:bg-blue-600 transition" type="submit">Submit</button>
        </div>
      </form>
    </div>

  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import Navbar from '../../components/Navbar.vue';
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'

const form = useForm({
  title: "",
  url: "",
})

const props = defineProps({
  user: Object,
  submission: Object,
  path: String
})
</script>
