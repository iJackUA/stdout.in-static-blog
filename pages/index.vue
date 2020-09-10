<template>
  <div>
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
        <!-- // eslint-disable-next-line -->
        <div class="px-5 py-5 bg-green-200 prose" v-html="post.excerpt" />
      </NuxtLink>
    </div>
  </div>
</template>

<script>
export default {
  async asyncData ({ $content }) {
    const posts = await $content('posts').limit(20).sortBy('date', 'desc').fetch()

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

.title {
  font-family:
    'Quicksand',
    'Source Sans Pro',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    'Helvetica Neue',
    Arial,
    sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>
