gulp = require 'gulp'
coffee = require 'gulp-coffee'
changed = require 'gulp-changed'
del = require 'del'
remote = require 'gulp-remote-src'
sass = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'
uglify = require 'gulp-uglify'

BUILD_DIR = './dist'

gulp.task 'coffee', ->
  gulp.src './src/**/*.coffee'
    .pipe sourcemaps.init()
    .pipe changed BUILD_DIR, {extension: '.js'}
    .pipe coffee
      bare: true
    .pipe uglify()
    .pipe sourcemaps.write()
    .pipe gulp.dest BUILD_DIR

gulp.task 'sass', ->
  gulp.src './src/**/*.sass'
  .pipe sourcemaps.init()
  .pipe changed BUILD_DIR, {extension: '.css'}
  .pipe sass()
  .pipe sourcemaps.write()
  .pipe gulp.dest BUILD_DIR

gulp.task 'copy', [
  'copy:config'
  'copy:jade'
]

gulp.task 'copy:config', ->
  gulp.src './src/config.json'
    .pipe gulp.dest BUILD_DIR

gulp.task 'copy:jade', ->
  gulp.src './src/**/*.jade'
    .pipe gulp.dest BUILD_DIR

gulp.task 'download', [
  'download:bootstrap'
  'download:teacup'
]

gulp.task 'download:bootstrap', ->
  remote ['bootstrap.min.css'], {base: 'http://bootswatch.com/journal/'}
    .pipe gulp.dest BUILD_DIR + '/css'

gulp.task 'download:teacup', ->
  remote ['teacup.js'], {base: 'https://raw.githubusercontent.com/goodeggs/teacup/master/lib/'}
    .pipe gulp.dest BUILD_DIR + '/front_js'

gulp.task 'default', [
  'coffee'
  'sass'
  'copy'
]

gulp.task 'clean', ->
  del BUILD_DIR