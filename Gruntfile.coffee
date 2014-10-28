module.exports = (grunt) ->
  # -----------------------------------
  # load Plugins
  # -----------------------------------
  require('load-grunt-tasks')(grunt);

  require('time-grunt')(grunt);

  grunt.config.init
    compass:
      dev:
        options:
          sassDir: 'demo'
          cssDir: 'demo'
          outputStyle: 'compressed'

    clean:
      dist:
        files: [
          {
            dot: true
            src: ['dist']
          }
        ]
      dev:
        files: [
          {
            dot: true
            src: ['.tmp']
          }
        ]
      docs:
        files: [
          {
            dot: true
            src: ['docs']
          }
        ]

    coffee:
      api:
        expand: true
        cwd: 'src'
        src: ['module.coffee'
              'extensions/*.coffee']
        dest: '.tmp'
        ext: '.js'
      demo:
        files:
          'demo/demo.js': 'demo/demo.coffee'

    jade:
      compile:
        options:
          data:
            debug: true

        files: [
          cwd: "demo"
          src: "index.jade"
          dest: "demo"
          ext: ".html"
          expand: true
        ]

    concat:
      options:
        separator: ';'
      dist:
        src: ['.tmp/module.js'
              '.tmp/extensions/*.js']
        dest: 'dist/angular-rails-resource-extend.js'

    ngAnnotate:
      options:
        singleQuotes: true
      dist:
        files:
          'dist/angular-rails-resource-extend.js': ['dist/angular-rails-resource-extend.js']

    uglify:
      build:
        files:
          'dist/angular-rails-resource-extend.min.js': 'dist/angular-rails-resource-extend.js'

    watch:
      compass:
        files: ['demo/*.scss']
        tasks: ['compass']
        options:
          spawn: no
      coffee:
        files: ['src/*.coffee', 'rules/*.coffee', 'demo/*.coffee']
        tasks: ['coffee']
        options:
          spawn: no
      jade:
        files: ["demo/index.jade"]
        tasks: ["jade"]

    html2js:
      options:
        base: '.'
        module: 'easy.form.templates'
        rename: (modulePath) ->
          moduleName = modulePath.replace('src/', '').replace('.html', '');
          return 'easy-form' + '/' + moduleName + '.html'
      default:
        src: ['src/templates/**/*.html']
        dest: 'src/templates/templates.js'

    connect:
      options:
        protocol: 'http'
        hostname: '*'
        port: 9000
        base: '.'
      livereload:
        options:
          open: true

    karma:
      dev:
        configFile: 'test/karma-dev.conf.js'
      dist:
        configFile: 'test/karma-dist.conf.js'

    wiredep:
      demo:
        src: ['demo/index.jade', 'demo/demo.scss']
      test:
        src: ['test/karma.conf.coffee'],
        ignorePath: '../'
        devDependencies: true
        fileTypes:
          js:
            block: /(([\s\t]*)\/\/\s*bower:*(\S*))(\n|\r|.)*?(\/\/\s*endbower)/gi,
            detect: {}
            replace:
              js: '\'{{filePath}}\','

    ngdocs:
      options:
        dest: 'docs'
        title: "Angular Easy form"
        startPage: '/api'
      api:
        src: ['.tmp/module.js',
              '.tmp/providers/*.js',
              '.tmp/directives/input.js']
        title: 'API Documentation'
      tutorial:
        src: 'content/tutorial/*.ngdoc'
        title: 'Tutorial'


  # -----------------------------------
  # register task
  # -----------------------------------

  grunt.registerTask 'dev', [
    'clean:dev'
    'compass'
    'coffee'
    'jade'
    'connect'
    'watch'
  ]
  grunt.registerTask 'build', [
    'clean:dist'
    'clean:dev'
    'wiredep'
    'coffee'
    'html2js'
    'jade'
    'concat'
    'ngAnnotate'
    'uglify'
  ]
  grunt.registerTask 'test', ['karma']
  grunt.registerTask 'docs', [
    'clean:docs',
    'build'
    'ngdocs'
  ]
