'use strict'

const utils = require('./utils')

const isProduction = process.env.NODE_ENV === 'production'

module.exports = {
  loaders: utils.cssLoaders({
    sourceMap: isProduction ? '#hidden-source-map' : '#cheap-module-eval-source-map',
    extract: isProduction
  }),
  postcss: [
    require('autoprefixer')({
      browsers: ['last 3 versions']
    })
  ]
}
