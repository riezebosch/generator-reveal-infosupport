var gulp = require('gulp');
var spawn = require('cross-spawn')
var template = require('gulp-template')
var dirTree = require('directory-tree')
var watch = require('gulp-watch')
var batch = require('gulp-batch')
var connect = require('gulp-connect');
var portastic = require('portastic')
var open = require('opn')

gulp.task('serve', ['build', 'watch'], function() {
    portastic
        .find({ min: 9000, max: 9999, retrieve: 2 })
        .then(function(port) {
            open('http://localhost:' + port[0] + '/')
            connect.server({
                root: '.',
                port: port[0],
                livereload: { port: port[1] }
            });
        })
});

gulp.task('print', ['build'], function() {
    var input = 'file:///' + process.cwd() + '/index.html?print-pdf';
    spawn('phantomjs', ['bower_components/reveal.js/plugin/print-pdf/print-pdf.js', input, 'slides.pdf'], { stdio: 'inherit'});
});

gulp.task('build', function() {
    var slides = dirTree('slides')
    gulp
        .src('templates/index.html')
        .pipe(template({ data: slides }))
        .pipe(gulp.dest('.'))
        .pipe(connect.reload())
});

gulp.task('watch', function () {
    watch('slides/**', batch(function (events, done) {
        gulp.start('build', done);
    }));
});