import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000, // 기본 포트를 3000으로 변경
    proxy: {
      '/api': {
        target: 'http://localhost:80', // 백엔드 서버 주소로 수정
        changeOrigin: true,
        secure: false,
      },
    },
  },
});