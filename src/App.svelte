<script lang="ts">
  import { onMount } from 'svelte';
  import defaultThumbnail from './assets/default-thumbnail.webp';

  let routes: any[] = [];

  onMount(async () => {
    const response = await fetch('/routes/routes.json');
    routes = await response.json();
  });

  $: {
    
  }
</script>

<main>
  {#each routes as route}
    <a href={route['src_path']+'/'+route['src_file']}>
      <h2>{route['title']}</h2>
      <p>{route['description']}</p>
      <img src={route['thumbnail'] ? (route['src_path']+'/'+route['thumbnail']):defaultThumbnail} alt={route['title']} width="200" height="200" />
    </a>
  {/each}
</main>

<style>
</style>
