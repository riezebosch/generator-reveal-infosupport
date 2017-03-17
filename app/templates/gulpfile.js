var gulp = require('gulp');
var spawn = require('cross-spawn')
var template = require('gulp-template')
var dirTree = require('directory-tree')
var watch = require('gulp-watch')
var batch = require('gulp-batch')
var server = require('gulp-webserver');

gulp.task('serve', ['build', 'watch'], function() {
  gulp.src('.')
    .pipe(server({
      livereload: true,
      open: true,
      port: 9000
    }));
});

gulp.task('print', ['build'], function() {
    // construct file path url for phantomjs
    var input = 'file:///' + process.cwd() + '/index.html?print-pdf';
    spawn('phantomjs', ['bower_components/reveal.js/plugin/print-pdf/print-pdf.js', input, 'slides.pdf'], { stdio: 'inherit'});
});

gulp.task('build', function() {
  var slides = dirTree('slides')
  gulp
    .src('templates/index.html')
    .pipe(template({ data: slides }))
    .pipe(gulp.dest('.'))
});

gulp.task('watch', function () {
    watch('slides/**', batch(function (events, done) {
        gulp.start('build', done);
    }));
});