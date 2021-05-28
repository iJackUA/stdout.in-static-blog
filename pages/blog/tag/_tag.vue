<template>
  <div>
    Post for tag: {{ tag }}
    <div
      v-for="post in posts"
      :key="post.path"
    >
      <NuxtLink :to="{ name: 'blog-slug', params: { slug: post.slug }}">
        <h1 class="text-xl">
          {{ post.title }}
        </h1>
        <h3>
          {{ post.readingTime.text }}
        </h3>
        <nuxt-content :document="{body: post.excerpt}" class="px-5 py-5 bg-green-200 prose" />
      </NuxtLink>
    </div>
  </div>
</template>

<script>
export default {
  async asyncData ({ $content, params }) {
    const posts = await $content('posts/en')
      .where({ tags: { $contains: params.tag } })
      .limit(5)
      .sortBy('date', 'desc')
      .fetch()

    const tag = params.tag

    return {
      posts,
      tag
    }
  }
}
</script>

<style>

</style>
