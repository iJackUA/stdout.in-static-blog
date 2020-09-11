<template>
  <div>
    <article class="prose max-w-none">
      <h1 class="text-center">
        {{ post.title }}
      </h1>
      <h3>
        {{ post.readingTime.text }}
      </h3>

      <nuxt-content :document="post" />
    </article>

    <div>
      <!-- <NuxtLink
        v-if="prev"
        class="rounded-sm bg-teal-500 px-4 py-4 hover:bg-teal-900"
        :to="{ name: 'blog-slug', params: { slug: prev.slug } }"
      >
        {{ prev.title }}
      </NuxtLink> -->

      <NuxtLink
        v-if="next"
        class="rounded-sm bg-pink-500 px-4 py-4 hover:bg-pink-900"
        :to="{ name: 'blog-slug', params: { slug: next.slug } }"
      >
        Read next: {{ next.title }}
      </NuxtLink>
    </div>
  </div>
</template>

<script>
export default {
  async asyncData ({ $content, params }) {
    const post = await $content('posts', params.slug).fetch()

    const [prev, next] = await $content('posts')
      .only(['title', 'slug'])
      .sortBy('createdAt', 'asc')
      .surround(params.slug)
      .fetch()

    return { post, prev, next }
  }
}
</script>
