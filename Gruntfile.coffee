module.exports = ( grunt ) ->

  grunt.initConfig
    target: './build'
    source: './src'
    public: '<%= target %>/public'
    scripts: '<%= public %>/scripts'


    # copies site files
    copy:
      content:
        expand: true,
        dest: '<%= target %>'
        cwd: '<%= source %>'
        src: ['**',
          # skip processed files
          '!**/*.{jade,coffee,sass}'] #,css,png,jpg}' ]

      views:
        expand: true,
        dest: '<%= target %>'
        cwd: '<%= source %>'
        src: ['**/*.jade' ]

    # compiles coffee script
    coffee:
      www:
        expand: true,
        cwd: '<%= source %>'
        dest: '<%= target %>'
        src: ['**/*.coffee']
        ext: '.js'

    # compiles jade to html
    jade:
      www:
        expand: true,
        cwd: '<%= source %>'
        dest: '<%= target %>'
        src: ['**/*.jade']
        ext: '.html'


    # compress css
    cssmin:
      www:
        expand: true,
        cwd: '<%= target %>'
        dest: '<%= target %>'
        src: [ 'public/**/*.css' ]

    # javascript compression
    uglify:
      options:
        mangle: false

      www:
        dest: '<%= public %>/app.js'
        src: [ '<%= public %>/app.js' ]

    # compiles coffee script
    compass:
      www:
        options:
          sassDir: '<%= source %>/public/ui'
          cssDir: '<%= target %>/public/ui'
          # environment: 'production'

    # cleanup for deployment
    clean:
      start:
        src: '<%= target %>/*'

      # last cleanup before deploy
      finish:
        src:[
          '<%= public %>/scripts'
        ]


    # combine files
    concat:
      www:
        src: [

          # misc libraries
          '<%= scripts %>/lib/*.js'

          # order dependency
          '<%= scripts %>/angular.js'
          '<%= scripts %>/angular/*.js'

          # initialize the app
          '<%= scripts %>/init.js'
          '<%= scripts %>/controllers/*.js'
          '<%= scripts %>/components/*.js'
          '<%= scripts %>/directives/*.js'
          '<%= scripts %>/services/*.js'

        ]
        dest: '<%= target %>/public/app.js'


    # development ( auto deploy )
    watch:
      other:
        expand: true
        files: '<%= source %>/public/*'
        tasks: [ 'copy' ]
        options: { nospawn: true }

      views:
        expand: true
        files: '<%= source %>/**/*.jade'
        tasks: [ 'copy:views' ]
        options: { nospawn: true }

      scripts:
        files: '<%= source %>/**/*.coffee'
        tasks: [ 'coffee', 'concat' ]
        options: { nospawn: true }

      styles:
        files: '<%= source %>/**/*.sass'
        tasks: [ 'compass' ]
        options: { nospawn: true }



  # register tasks
  for task in [
    'grunt-iced-coffee',
    'grunt-contrib-compass',
    'grunt-contrib-cssmin',
    'grunt-contrib-jade',
    'grunt-contrib-copy',
    'grunt-contrib-clean',
    'grunt-contrib-concat',
    'grunt-contrib-watch',
    'grunt-contrib-uglify'
    ]
    # load each task
    grunt.loadNpmTasks task


  # setup tasks
  grunt.registerTask 'build', [ 'clean:start', 'copy', 'coffee', 'concat', 'compass' ]
  grunt.registerTask 'deploy', [ 'build', 'uglify', 'cssmin', 'clean:finish' ]
  grunt.registerTask 'auto', [ 'watch' ]


