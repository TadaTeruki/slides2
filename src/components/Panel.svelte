<script lang="ts">
    import type { SlideRoute } from '../lib/slide';

    export let slideRoute: SlideRoute;

    $: console.log(slideRoute);
</script>

<a href={slideRoute.slide} class="panel">
    <div class="desc desc-1">
        {slideRoute.date.getFullYear()}年{slideRoute.date.getMonth() + 1}月{slideRoute.date.getDate()}日<br />
        {slideRoute.session}
    </div>
    <div class="desc desc-2">
        <div class="title">
            {slideRoute.title}
            <span class="title">
                {#if slideRoute.tags.length > 0}
                    {#each slideRoute.tags as tag}
                        <span class="tag">{tag}</span>
                    {/each}
                {/if}
            </span>
        </div>
        {slideRoute.description}

    </div>

    <img src={slideRoute.thumbnail} alt={slideRoute.title} />
</a>

<style>
    .panel {
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 5px;
        overflow: hidden;
        margin: 0.75em 0;
        height: 5.0em;
        background-color: #f8f8f8;
        white-space: nowrap;

        border-width: 5px;
        transition: background-color box-shadow;
        transition-duration: 0.2s;

        box-shadow: 0;
    }

    .panel:hover {
        background-color: #def3ec;
        box-shadow: 0 0 8px #def3ec;
    }

    .desc {
        padding: auto;
        line-height: 1.3;
        height: fit-content;
    }

    .desc-1 {
        width: 9em;
        text-align: center;
        overflow: hidden;
    }

    .desc-2 {
        flex: 1;
        overflow: hidden;
    }

    .title {
        font-size: 1.2em;
        font-weight: bold;
    }

    .tag {
        padding: 0 0.4em 0.1em 0.4em;
        border-radius: 3px;
        margin: auto 0.2em;
        font-size: 0.5em;
        background-color: #426390;
        color: white;
    }

    .panel img {
        width: 30%;
        overflow: hidden;
        object-fit: cover;
        margin: 0;
    }

    @media (max-width: 40em) {
        .panel img {
            display: none;
        }
    }
</style>