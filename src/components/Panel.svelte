<script lang="ts">
    import type { SlideRoute } from '../lib/slide';

    export let slideRoute: SlideRoute;

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

    <a href={slideRoute.slidePdf} class="download">
        PDF&ensp;<img src="src/assets/download.svg" alt="PDF" class="pdfimage"/>
    </a>

    <img src={slideRoute.thumbnail} alt={slideRoute.title} class="thumbnail" />
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

    .download {
        margin: auto 1.0em;
        padding: 0.3em 0.6em;
        width: fit-content;
        height: fit-content;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 0.3em;
        background-color: #5d3f8d;
        overflow: hidden;

        color: white;
        font-size: 0.9em;
        font-weight: bold;

        transition: background-color;
        transition-duration: 0.2s;
    }

    .download:hover {
        background-color: #3a1970;
    }

    img.pdfimage {
        margin: auto;
        width: 1.0em;
        height: 1.0em;
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

    img.thumbnail {
        width: 25%;
        overflow: hidden;
        object-fit: cover;
        margin: 0;
    }

    @media (max-width: 60em) {
        img.thumbnail {
            display: none;
        }
    }
</style>