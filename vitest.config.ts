import { defineConfig, mergeConfig } from 'vitest/config'
import viteConfig from './vite.config'

export default mergeConfig(viteConfig, defineConfig({
  test: {
    environment: 'jsdom',
    globals: true,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'html'],
      include: ['app/javascript/**/*.{ts,vue}'],
      exclude: [
        'app/javascript/**/*.spec.ts',
        'app/javascript/**/*.d.ts',
        'app/javascript/entrypoints/application.ts',
      ],
    },
  },
}))
