module.exports = function(grunt) {

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    // no emblem for now (xenor)

    // emblem: {
    //   compile: {
    //     files: {
    //       'app/js/templates.js': ['app/js/templates/**/*.emblem']
    //     },
    //     options: {
    //       root: 'app/js/templates/',
    //       dependencies: {
    //         jquery: 'static/js/vendor/jquery-1.9.1.min.js',
    //         emblem: 'static/js/vendor/emblem-0.2.9.min.js',
    //         handlebars: 'static/js/vendor/handlebars-1.0.0-rc.4.js'
    //         ember: 'static/js/vendor/ember-1.0.0-rc.6.min.js'
    //       }
    //     }
    //   }
    // },
    ember_handlebars: {
      compile: {
        options: {
          processName: function(filename) {
            return filename.match(/.*\/(.*).hbs$/)[1];
          }
        },
        files: {
          'app/js/templates.js': ['app/js/templates/**/*.hbs']
        }
      }
    },
    coffee: {
      dist: {
        files: [{
          // rather than compiling multiple files here you should
          // require them into your main .coffee file
          expand: true,
          cwd: 'app/js/',
          src: '**/*.coffee',
          dest: '.tmp/js',
          ext: '.js'
        }]
      },
      test: {
        files: [{
          expand: true,
          cwd: '.tmp/spec',
          src: '*.coffee',
          dest: 'test/spec'
        }]
      }
    },
    concat: {
      dist: {
        src: [
          'app/js/lib/*.js',
          '.tmp/js/app.js',
          '.tmp/js/store.js',
          '.tmp/js/router.js',
          'app/js/templates.js',
          '.tmp/js/classes/*.js'
        ],
        dest: 'static/js/app.js'
      },
      dev: {
        src: [
          'app/js/lib/*.js',
          '.tmp/js/app.js',
          '.tmp/js/dev.js',
          '.tmp/js/store.js',
          '.tmp/js/router.js',
          'app/js/templates.js',
          '.tmp/js/classes/*.js'
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
      coffee: {
        files: ['app/js/**/*.coffee'],
        tasks: ['coffee:dist', 'concat', 'uglify']
      },
      gruntfile: {
        files: ['Gruntfile.js'],
        tasks: ['jshint:gruntfile']
      },
      css: {
        files: 'app/css/*.scss',
        tasks: ['compass'],
        events: true
      },
      // emblem: {
      //   files: 'app/js/templates/**/*.emblem',
      //   tasks: ['emblem', 'concat', 'uglify']
      // },
      handlebars: {
        files: 'app/js/templates/**/*.hbs',
        tasks: ['ember_handlebars', 'concat', 'uglify']
      }
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
         "force": true
      },
      ember: [ 'app/js/**/*.js', '!app/js/templates.js' ],
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
    }
  });

  grunt.registerTask('default', [
    'ember_handlebars',
    'coffee',
    'concat:dist',
    'uglify',
    'compass',
    'regarde'
  ]);

  grunt.registerTask('dev', [
    'ember_handlebars',
    'coffee',
    'concat:dev',
    'uglify',
    'compass',
    'regarde'
  ]);

  grunt.renameTask('rsync', 'deploy');

};