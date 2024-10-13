<script lang="ts">
  import { onMount } from 'svelte';
  import Panel from './components/Panel.svelte';
  import Frame from './components/Frame.svelte';
  import { SlideRoute } from './lib/slide';
  
  let slideRoutes: SlideRoute[] = [];
  onMount(async () => {
    const response = await fetch('/routes/routes.json');
    let routes: SlideRoute[] = [];
    for (const route of await response.json()) {
      routes.push(new SlideRoute(route));
    }
    routes.sort((a, b) => b.date.getTime() - a.date.getTime());
    slideRoutes = routes;
  });
  
</script>

<header>
  <Frame>
    <div class="headinfo">
      <h1>多田 瑛貴のスライド一覧</h1>
      これまでに発表したスライドの一覧です。
    </div>
  </Frame>
</header>

<main>
  <Frame>
    {#each slideRoutes as route}
      <Panel
        slideRoute={route}
      />
    {/each}
  </Frame>
</main>

<footer>
  <Frame>
    View Source: <a href="https://github.com/TadaTeruki/slides2" class="source">GitHub</a><br />
    Copyright © 2024 Teruki Tada
  </Frame>
</footer>

<style>
  main {
    padding: 1em 0;
  }

  header {
    background-image: linear-gradient(110deg, #115f73, #265189);
    color: white;
    height: 15em;

    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    text-align: left;

    padding: 1.25em 0;
  }

  header h1 {
    margin: 0;
    font-size: 2em;
  }

  footer {
    height: 12em;
    text-align: center;
    padding: 1.25em 0;

    font-size: smaller;
    color: #666;
  }

  .headinfo {
    width: 100vw;
  }

  .source {
    text-decoration: underline;
  }
</style>
