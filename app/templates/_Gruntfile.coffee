module.exports = (grunt) ->
  
  grunt.loadNpmTasks 'grunt-express-server'

  grunt.initConfig
    express:
      server:
        options:
          background: false
          script: 'server/server.coffee'

  grunt.registerTask 'default', ['express']
