const defaultTheme = require('tailwindcss/defaultTheme')
const plugin = require('tailwindcss/plugin')

module.exports = {
  content: ["content/**/*.md", "./layouts/**/*.twig"],
  theme: {
    extend: {
      colors: {
        primary: {
          light: '#112240',
          DEFAULT: '#0a192f'
        },
      },
      fontFamily: {
        arvo: ['Arvo'],
        sans: ['Roboto', ...defaultTheme.fontFamily.sans]
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    plugin(function({ addVariant }) {
      addVariant('optional', '&:optional')
      addVariant('hocus', ['&:hover', '&:focus'])
      addVariant('supports-grid', '@supports (display: grid)')
    })
  ],
}