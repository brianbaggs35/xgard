import '@hotwired/turbo-rails'
import { createApp, type App, type Component } from 'vue'
import PrimeVue from 'primevue/config'
import Aura from '@primeuix/themes/aura'

// Registry of all Vue components used in the app
// We'll add components here as we build them
const components: Record<string, Component> = {}

// Finds every element with a data-vue-component attribute
// and mounts the matching Vue component onto it
function mountComponents(): void {
  document.querySelectorAll('[data-vue-component]').forEach((el) => {
    const name = (el as HTMLElement).dataset.vueComponent
    if (!name || !components[name]) return

    const app: App = createApp(components[name])
    app.use(PrimeVue, {
      theme: {
        preset: Aura,
        options: { darkModeSelector: '.dark' },
      },
    })
    app.mount(el)
  })
}

document.addEventListener('DOMContentLoaded', mountComponents)
document.addEventListener('turbo:load', mountComponents)
