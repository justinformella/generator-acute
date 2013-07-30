module.exports = (grunt) ->
  
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig
    jade:
      dev:
        files: [ '.tmp/index.html': 'app/index.jade'
               ]
    express:
      server:
        options:
          background: false
          script: 'server/server.coffee'

  grunt.registerTask 'default', ['jade:dev','express']
