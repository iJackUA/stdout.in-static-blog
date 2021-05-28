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
          class="rounded-lg bg-orange-300 px-2 flex"
        >
          {{ page }}
        </NuxtLink>
      </li>
    </ul>

    <div
      v-for="note in notes"
      :key="note.path"
    >
      <NuxtLink :to="{ name: 'blog-notes-id', params: { id: note.path } }">
        <h1 class="text-xl">
          {{ note.date }}
        </h1>
        <nuxt-content :document="note" class="px-5 py-5 bg-green-200 prose" />
      </NuxtLink>

      <ul class="tags">
        <li
          v-for="tag in note.tags"
          :key="tag"
          class="rounded-lg bg-purple-300 inline-block px-3"
        >
          <NuxtLink :to="{ name: 'blog-tag-tag', params: { tag: tag }}">
            {{ tag }}
          </NuxtLink>
        </li>
      </ul>
    </div>
  </main>
</template>

<script>
export default {
  async asyncData ({ $content, params }) {
    const perPage = 10
    const page = params.page || 1
    const notesForPagination = await $content('notes').fetch()
    const total = Math.round(notesForPagination.length / perPage)
    const pagination = {
      page,
      perPage,
      total
    }

    const skip = page ? page * perPage : 0
    const notes = await $content('notes').skip(skip).limit(5).sortBy('date', 'desc').fetch()

    return {
      notes,
      pagination
    }
  }
}
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

</style>
