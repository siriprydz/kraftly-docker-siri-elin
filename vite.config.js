import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  test: {
    globals: true, // krävs för att Testing Library ska städa DOM:en mellan tester
    environment: 'jsdom',
    setupFiles: ['./tests/setup.js']
  }
})
