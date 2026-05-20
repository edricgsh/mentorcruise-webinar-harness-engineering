import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig(({ mode }) => {
  // Load .env from the repo root (one level up from frontend/)
  const env = loadEnv(mode, path.resolve(__dirname, '..'), '')
  return {
    plugins: [react()],
    server: {
      port: parseInt(env.VITE_PORT) || 5173,
    },
    define: {
      // Expose VITE_* vars to the browser bundle
      'import.meta.env.VITE_API_URL': JSON.stringify(env.VITE_API_URL || 'http://localhost:3001'),
    },
  }
})
