<template>
  <div class="bg-stone-800 text-white py-4">
    <div class="container mx-auto flex items-center flex-row justify-between">
      <span class="text-3xl font-dm-serif">kai</span>
      <div class="flex flex-row gap-4 items-center" v-if="user">
        <a class="font-medium">{{ user.email }}</a>
        <Link class="px-4 py-2 hover:bg-black rounded"href="/users/sign_out" as="button" method="delete">Logout</Link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Link } from '@inertiajs/vue3'
import { ref } from 'vue'
const { user } = defineProps<{
  user: Object,
}>()
</script>

<style scoped></style>
