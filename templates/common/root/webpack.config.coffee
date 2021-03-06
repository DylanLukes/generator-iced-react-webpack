#
# * Webpack development server configuration
# *
# * This file is set up for serving the webpak-dev-server, which will watch for changes and recompile as required if
# * the subfolder /webpack-dev-server/ is visited. Visiting the root will not automatically reload.
# 

'use strict'

module.exports =
  output:
    filename: 'main.js'

  cache: true
  debug: true
  devtool: false
  entry: './src/scripts/components/<%= pkg.mainInput %>.jsx'
  stats:
    colors: true
    reasons: true

  module:
    preLoaders: [
      {
      test: /\.(coffee|iced)$/,
      exclude: 'node_modules',
      loader: 'iced-loader'
      }
    ]
    loaders: [
      {
        test: /\.css$/
        loader: "style!css"
      }
      {
        test: /\.gif/
        loader: "url-loader?limit=10000&minetype=image/gif"
      }
      {
        test: /\.jpg/
        loader: "url-loader?limit=10000&minetype=image/jpg"
      }
      {
        test: /\.png/
        loader: "url-loader?limit=10000&minetype=image/png"
      }
      {
        test: /\.(coffee|iced|jsx)$/
        loader: "jsx-loader"
      }
    ]