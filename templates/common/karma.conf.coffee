'use strict'

module.exports = (config) ->
  config.set
    basePath: ''
    frameworks: ['jasmine']
    files: [
      'test/helpers/**/*.iced'
      'test/spec/components/**/*.iced'
    ]
    preprocessors:
      'test/spec/components/**/*.iced': ['webpack']

    webpack:
      cache: true
      module:
        preLoaders: [
          test: /\.(coffee|iced)$/,
          exclude: 'node_modules',
          loader: 'iced-loader'
        ]
        loaders: [
          {
            test: /\.css$/
            loader: 'style!css'
          }
          {
            test: /\.gif/
            loader: 'url-loader?limit=10000&minetype=image/gif'
          }
          {
            test: /\.jpg/
            loader: 'url-loader?limit=10000&minetype=image/jpg'
          }
          {
            test: /\.png/
            loader: 'url-loader?limit=10000&minetype=image/png'
          }
          {
            test: /\.(coffee|iced|jsx)$/
            loader: 'jsx-loader'
          }
        ]

    webpackServer:
      stats:
        colors: true

    exclude: []
    port: 8080
    logLevel: config.LOG_INFO
    colors: true
    autoWatch: false
    
    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ['PhantomJS']
    reporters: ['progress']
    captureTimeout: 60000
    singleRun: true

  return