import { defineConfig } from 'vitest/config'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue(),
  ],
  test: {
    environment: 'jsdom',
    globals: true,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html'],
      include: ['app/javascript/**/*.{ts,vue}'],
      exclude: ['app/javascript/**/*.spec.ts', 'app/javascript/**/*.d.ts', 'app/javascript/entrypoints/application.ts'],
    },
  },
})
