<template>
  <div class="mermaid">
    <slot />
  </div>
</template>

<script>
export default {
  beforeMount () {
    // Try to remaki a single init in Nuxt Plugin and use here instance
    import('mermaid/dist/mermaid.min').then((m) => {
      m.initialize({
        startOnLoad: true
      })
      m.init()
    })
  }
}
</script>
