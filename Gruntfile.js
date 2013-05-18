module.exports = function(grunt) {

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    concat: {
      dist: {
        src: [
          'app/js/app.js',
          'app/js/routes.js',
          'app/js/store.js',
          'app/js/routes/*.js',
          'app/js/models/*.js',
          'app/js/controllers/*.js',
          'app/js/views/*.js',
          'app/js/helpers/*.js',
          'app/js/lib/*.js'
        ],
        dest: 'static/js/app.js'
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'static/js/app.js',
        dest: 'static/js/app.min.js'
      }
    },
    compass: {
      dist: {
        options: {
          config: 'app/config/compass.rb',
          force: true
        }
      }
    },
    webfont: {
      icons: {
        src: 'static/icons/*.svg',
        dest: 'fonts',
        options: {
            font: 'gwcicons'
        }
      }
    },
    regarde: {
      js: {
        files: ['app/js/**/*.js'],
        tasks: ['jshint:ember', 'concat', 'uglify']
      },
      gruntfile: {
        files: ['Gruntfile.js'],
        tasks: ['jshint:gruntfile']
      },
      css: {
        files: 'app/css/*.scss',
        tasks: ['compass'],
        events: true
      }
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
         "force": true
      },
      ember: [ 'app/js/**/*.js' ],
      gruntfile: ['Gruntfile.js']
    },
    deploy: {
      staging: {
        src: "./",
        dest: "~/www/gwc-corp",
        host: "dev@staging.golfwebclub.com",
        recursive: true,
        syncDest: true,
        exclude: [
          '.git*',
          'Gemfile*',
          'Rakefile',
          'stuff',
          'sfnt2woff',
          'scss',
          'scss-base',
          'components',
          'node_modules',
          '.sass-cache',
          'Gruntfile.js',
          'package.json',
          'README.md',
          'config.rb'
        ]
      },
      production: {
        src: "./",
        dest: "~/www/gwc-corp",
        host: "dev@live.golfwebclub.com",
        recursive: true,
        syncDest: true,
        exclude: '<%= rsync.staging.exclude %>'
      }
    },
    emblem: {
      compile: {
        files: {
          'path/to/result.js': 'path/to/source.emblem', //1:1 compile
          'path/to/another.js': ['path/to/sources/*.emblem', 'path/to/more/*.emblem'] //compile and concat into single file
        },
        options: {
          root: 'app/templates/',
          dependencies: {
            jquery: 'js/vendor/jquery-1.9.1.js',
            ember: 'js/vendor/ember-1.0.0-rc.1.js',
            emblem: 'js/vendor/emblem.js',
            handlebars: 'js/vendor/handlebars-1.0.0-rc.3.js'
          }
        }
      }
    }
  });

  grunt.registerTask('default', [
     'regarde'
  ]);

  grunt.renameTask('rsync', 'deploy');

};