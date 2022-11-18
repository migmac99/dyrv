import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import {resolve} from 'path'

export default defineConfig(({ command, mode })=> {
  console.log('vite.config.ts: ', { command, mode })
  return {
    resolve:{
      alias:{
        'src': resolve(__dirname,'src'),
      }
    },
    esbuild: {
      loader: 'jsx',
      include: /src\/.*\.jsx?$/,
      // loader: "tsx",
      // include: /src\/.*\.[tj]sx?$/,
      exclude: [],
    },
    build: {
      outDir: 'build'
    },

    plugins: [react()]
  }
})
