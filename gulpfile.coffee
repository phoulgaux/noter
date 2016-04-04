gulp = require 'gulp'
coffee = require 'gulp-coffee'
changed = require 'gulp-changed'
del = require 'del'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'

BUILD_DIR = './dist'

gulp.task 'coffee', ->
  gulp.src './src/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe changed BUILD_DIR, {extension: '.js'}
    .pipe coffee()
    .pipe uglify()
    .pipe sourcemaps.write()
    .pipe gulp.dest BUILD_DIR

gulp.task 'copy', ['copy:config']

gulp.task 'copy:config', ->
  gulp.src './src/config.json'
    .pipe gulp.dest BUILD_DIR

gulp.task 'default', [
  'coffee'
  'copy'
]

gulp.task 'clean', ->
  del BUILD_DIR