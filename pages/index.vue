<template>
  <main>
    <div
      v-for="post in posts"
      :key="post.path"
    >
      <NuxtLink :to="{ name: 'blog-slug', params: { slug: post.slug } }">
        <h1 class="text-xl">
          {{ post.title }}
        </h1>
        <h3>
          {{ post.readingTime.text }}
        </h3>
        <ul>
          <li
            v-for="tag in post.tags"
            :key="tag"
            class="rounded-lg bg-purple-300 inline-block px-3"
          >
            <NuxtLink :to="{ name: 'blog-tag-tag', params: { tag: tag }}">
              {{ tag }}
            </NuxtLink>
          </li>
        </ul>
        <!-- // eslint-disable-next-line -->
        <div class="px-5 py-5 bg-green-200 prose max-w-none" v-html="post.excerpt" />
      </NuxtLink>
    </div>
  </main>
</template>

<script>
export default {
  async asyncData ({ $content }) {
    const posts = await $content('posts').limit(5).sortBy('date', 'desc').fetch()

    return {
      posts
    }
  }
}
</script>

<style>
/* Sample `apply` at-rules with Tailwind CSS
.container {
@apply min-h-screen flex justify-center items-center text-center mx-auto;
}
*/
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

</style>
