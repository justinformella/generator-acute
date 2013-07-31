module.exports = (grunt) ->
  
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.initConfig
    coffee:
      server:
        files: 
          '.server/server.js': 'server/server.coffee'
    watch:
      jade:
        atBegin: true
        files: 'app/**/*.jade'
        tasks: ['jade']
    jade:
      dev:
        files: [ '.tmp/index.html': 'app/index.jade'
               ]
    express:
      server:
        options:
          background: true
          script: '.server/server.js'

  grunt.registerTask 'server', ['coffee:server', 'express']
  grunt.registerTask 'default', ['server', 'watch']
