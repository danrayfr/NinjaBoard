const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans_serif: ['Merriweather'],
        poppins: ['Poppins'],
        mono: ['IBM Plex Mono'],
        jetbrains: ['JetBrains Mono']
      },
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        'white': '#ffffff',
        'graphite': '#23282E',
        'ivory': '#F3DAC9',
        'stone': '#B3B7B0',
        'coral': '#F05754',
        'fern': '#003822',
        'gold': '#EAB857',
        'lightGraphite': '#525559',
        'darkStone': '#919489',
        'paleFern': '#518F6F',
        'paleCoral': '#F9B4A4',
        'paleGold': '#FAD1A3',
        'offWhite': '#FFF8F5'
      },
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
