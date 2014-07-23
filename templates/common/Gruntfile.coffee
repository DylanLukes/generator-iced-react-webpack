'use strict'
mountFolder = (connect, dir) ->
  connect.static require('path').resolve(dir)

webpackDistConfig = require('./webpack.dist.config.coffee')
webpackDevConfig = require('./webpack.config.coffee')
module.exports = (grunt) ->
  
  # Let *load-grunt-tasks* require everything
  require('load-grunt-tasks') grunt
  
  # Read configuration from package.json
  pkgConfig = grunt.file.readJSON('package.json')
  grunt.initConfig
    pkg: pkgConfig
    webpack:
      options: webpackDistConfig
      dist:
        cache: false

    'webpack-dev-server':
      options:
        port: 8000
        webpack: webpackDevConfig
        publicPath: '/scripts/'
        contentBase: './<%= pkg.src %>/'

      start:
        keepAlive: true

    connect:
      options:
        port: 8000

      dist:
        options:
          keepalive: true
          middleware: (connect) ->
            [mountFolder(connect, pkgConfig.dist)]

    open:
      options:
        delay: 500

      dev:
        path: 'http://localhost:<%= connect.options.port %>/webpack-dev-server/'

      dist:
        path: 'http://localhost:<%= connect.options.port %>/'

    karma:
      unit:
        configFile: 'karma.conf.coffee'

    copy:
      dist:
        files: [
          {
            # includes files within path
            flatten: true
            expand: true
            src: ['<%= pkg.src %>/*']
            dest: '<%= pkg.dist %>/'
            filter: 'isFile'
          }
          {
            flatten: true
            expand: true
            src: ['<%= pkg.src %>/images/*']
            dest: '<%= pkg.dist %>/images/'
          }
        ]

    clean:
      dist:
        files: [
          dot: true
          src: ['<%= pkg.dist %>']
        ]

  grunt.registerTask 'serve', (target) ->
    if target is 'dist'
      return grunt.task.run([
        'build'
        'open:dist'
        'connect:dist'
      ])
    grunt.task.run [
      'open:dev'
      'webpack-dev-server'
    ]
    return

  grunt.registerTask 'test', ['karma']
  grunt.registerTask 'build', [
    'clean'
    'copy'
    'webpack'
  ]
  grunt.registerTask 'default', []
  return