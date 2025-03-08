<template>
  <div class="p-4 py-2 md:px-0 w-full bg-white shadow border-b border-b-slate-200">
    <div class="container mx-auto" v-if="user">
      <div class="grid grid-cols-3 items-center w-full">
        <div class="col-span-1 font-mono font-black text-lg">K.ai</div>
        <div class="justify-self-center col-span-1 rounded-full bg-slate-100 text-slate-500 px-4 py-2 w-48">Search</div>
        <div class="justify-self-end col-span-1 flex flex-row gap-4 items-center">
          {{user.name}}
          <form @submit.prevent="form.delete('/users/signout')">
            <button type="submit" class="px-4 py-2 rounded transition border-0 bg-white hover:bg-rose-100 text-rose-600">Logout</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'

const form = useForm({});

defineProps({
  user: Object,
})
</script>
