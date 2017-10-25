module.exports = (grunt) ->

  # configure modules
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['temp', 'dist']

    copy:
      public:
        expand: true
        cwd: 'public'
        src: '**'
        dest: 'dist'

    sass:
      dist:
        options:
          sourcemap: 'none'
          cacheLocation: 'temp/sass/'
        files: [
          expand: true
          cwd: 'src/sass'
          src: ['**/*.sass']
          dest: 'dist/css'
          ext: '.css'
        ]

    pug:
      compile:
        options:
          data:
            debug: false
        files: [
          expand: true
          cwd: 'src/pages'
          src: '**/*.pug'
          dest: 'dist'
          ext: '.html'
        ]

    coffee:
      transpile:
        expand: true
        flatten: false
        options:
          bare: true
        cwd: 'src'
        src: '**/*.coffee'
        dest: 'dist'
        ext: '.js'

    watch:
      src:
        options:
          livereload: true
        files: ['**/*.pug', '**/*.coffee', '**/*.sass', 'public/**']
        tasks: ['default']

    connect:
      server:
        options:
          port: 8080
          base: 'dist'
          open: true

  # Load grunt modules
  grunt.loadNpmTasks module for module in [
    'grunt-contrib-connect'
    'grunt-contrib-coffee'
    'grunt-contrib-clean'
    'grunt-contrib-copy'
    'grunt-contrib-pug'
    'grunt-contrib-sass'
    'grunt-contrib-watch'
  ]

  # Regsiter and define tasks
  grunt.registerTask 'transpile', ['coffee', 'sass', 'pug']
  grunt.registerTask 'default', ['clean', 'copy', 'transpile']
  grunt.registerTask 'live', ['default', 'connect', 'watch']
