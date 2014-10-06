module.exports = (grunt) ->
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.loadNpmTasks "grunt-mocha-test"
    grunt.loadNpmTasks "grunt-contrib-coffee"

    grunt.initConfig
        pkg: grunt.file.readJSON "package.json"

        coffee:
            default:
                options:
                    bare: true
                files:
                    "lib/<%= pkg.name %>.js": ["src/<%= pkg.name %>.coffee"]
                    "test/lib/test.js": ["test/src/test.coffee"]

        watch:
            configFiles:
                files: ["Gruntfile.coffee"]
                tasks: ["default"]
                options:
                    reload: true


            coffee:
                files: ["src/*.coffee","test/src/*.coffee"]
                tasks: ["default"]
                options:
                    atBegin: true
                    spawn: false
                    interrupt: true

        mochaTest:
            test:
                options:
                    reporter: "spec"
                    quiet: false
                src: ["test/lib/test.js"]

        grunt.registerTask "default", ["coffee"]
        grunt.registerTask "test", ["coffee", "mochaTest"]
