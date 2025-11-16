/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './hugo_stats.json',
    './layouts/**/*.html',
    './content/**/*.{md,html}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
