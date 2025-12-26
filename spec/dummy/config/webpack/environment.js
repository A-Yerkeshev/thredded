const { environment } = require('@rails/webpacker')
const sass = require('sass')
const erb = require('./loaders/erb')

environment.loaders.prepend('erb', erb)

// Force both sass-loader instances to use sass instead of the removed node-sass.
const setSassImplementation = (loader) => {
  if (!loader) return

  const sassLoader = loader.use.find(({ loader: currentLoader }) => currentLoader === 'sass-loader')
  if (sassLoader) {
    sassLoader.options = sassLoader.options || {}
    sassLoader.options.implementation = sass
  }
}

setSassImplementation(environment.loaders.get('sass'))
setSassImplementation(environment.loaders.get('moduleSass'))

module.exports = environment
