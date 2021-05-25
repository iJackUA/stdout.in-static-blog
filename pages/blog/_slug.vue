<template>
  <div>
    <article class="prose max-w-none">
      <h1 class="text-center">
        {{ post.title }}
      </h1>
      <h3>
        {{ post.readingTime.text }} | {{ dateFormatted }}
      </h3>

      <nav>
        <ul>
          <li v-for="link of post.toc" :key="link.id">
            <NuxtLink :to="`#${link.id}`">
              {{ link.text }}
            </NuxtLink>
          </li>
        </ul>
      </nav>

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
import { format } from 'date-fns'
import { enUS } from 'date-fns/locale'

export default {
  async asyncData ({ $content, params, $dateFns }) {
    const post = await $content('posts', params.slug).fetch()

    const [prev, next] = await $content('posts')
      .only(['title', 'slug'])
      .sortBy('createdAt', 'asc')
      .surround(params.slug)
      .fetch()

    const dateFormatted = format(new Date(post.createdAt), 'MMMM/dd/yyyy', { locale: enUS })

    return { post, prev, next, dateFormatted }
  }
}
</script>
