<template>
  <div class="layout-grid bg-blue-100 grid grid-cols-3 gap-1 h-screen sm:grid-cols-1 md:grid-cols-2">
    <header class="bg-purple-100 col-span-3 text-center">
      <!-- Header content -->
      <nuxt-link to="/">
        Blog
      </nuxt-link>
      <nuxt-link to="/talks">
        Talks
      </nuxt-link>
      <nuxt-link to="/projects">
        Projects
      </nuxt-link>
    </header>

    <aside class="bg-teal-100">
      <!-- Left side -->
    </aside>

    <main class="bg-pink-100">
      <!-- Main content -->
      <Nuxt />
    </main>

    <aside class="bg-orange-100">
      <!-- Right side -->
    </aside>

    <footer class="bg-purple-300 col-span-3">
      <!-- Footer content -->
      Footer
    </footer>
  </div>
</template>

<style lang="scss">
html {
  font-family: "Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI",
    Roboto, "Helvetica Neue", Arial, sans-serif;
  font-size: 16px;
  word-spacing: 1px;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  box-sizing: border-box;
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
}

.layout-grid {
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 1fr 800px 1fr;
}

header {
  a {
    @apply font-bold text-xl px-10
  }
}
</style>
