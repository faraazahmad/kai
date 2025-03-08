<template>
  <Head title="Inertia + Vite Ruby + Vue Example" />

  <div class="root">
    <Navbar :user="user" />
  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import Navbar from '../components/Navbar.vue';
import { ref } from 'vue'

defineProps({
  user: Object,
})
</script>
