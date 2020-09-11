<template>
  <main>
    <ul>
      <li
        v-for="page in pagination.total"
        :key="page"
        class="inline-block px-1"
      >
        <NuxtLink
          :to="{ name: 'blog-page-page', params: { page }}"
          class="rounded-lg bg-orange-300 px-2"
        >
          {{ page }}
        </NuxtLink>
      </li>
    </ul>

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
        <!-- <div class="px-5 py-5 bg-green-200 prose max-w-none" v-html="post.excerpt" /> -->
      </NuxtLink>
    </div>
  </main>
</template>

<script>
export default {
  async asyncData ({ $content, params }) {
    const perPage = 10
    const page = params.page || 1
    const postsForPagination = await $content('posts').only('title').fetch()
    const total = Math.round(postsForPagination.length / perPage)
    const pagination = {
      page,
      perPage,
      total
    }

    const skip = page ? page * perPage : 0
    const posts = await $content('posts').skip(skip).limit(5).sortBy('date', 'desc').fetch()

    return {
      posts,
      pagination
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
