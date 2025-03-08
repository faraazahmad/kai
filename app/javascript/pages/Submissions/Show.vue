<template>

  <Head title="Inertia + Vite Ruby + Vue Example" />

  <div>
    <Navbar :user="user" />
    <div class="pt-8 container mx-auto">
      <div class="w-full grid grid-cols-8 justify-items-stretch items-center">
        <h1 class="text-slate-800 col-span-6 text-3xl font-black pb-4">{{submission.title}}</h1>
        <div class="col-span-2 justify-self-end">
          <a class="bg-blue-100 border border-blue-200 hover:border-blue-700 text-blue-500 hover:bg-blue-600 rounded transition text-center shadow px-6 py-2 hover:text-white" :href="submission.url" target="_blank">Visit URL</a>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import Navbar from '../../components/Navbar.vue';
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'

const props = defineProps({
  user: Object,
  submission: Object,
})
</script>
