<template>
  <div>
    <article>
      <h1>{{ post.title }}</h1>
      <nuxt-content :document="post" />
    </article>

    <div>
      <NuxtLink v-if="prev" :to="{ name: 'blog-slug', params: { slug: prev.slug } }">
        {{ prev.title }}
      </NuxtLink>

      <NuxtLink v-if="next" :to="{ name: 'blog-slug', params: { slug: next.slug } }">
        {{ next.title }}
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
