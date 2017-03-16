'use strict'

path = require 'path'
fs = require 'fs'
yeoman = require 'yeoman-generator'
_assert = require 'assert'

coffeelint = require 'coffeelint'
jshintcli = require 'jshint/src/cli'

assert = require 'yeoman-assert'
helpers = require 'yeoman-test'

lint_generated_files = (cb) ->

    jshintcli.loadConfig path.join __dirname, '../app/templates/jshintrc'
    jshintcli.run args: ['js/loadhtmlslides.js'], reporter: (results, data) ->
        _assert.strictEqual results.length, 0, 'Generated js/loadhtmlslides.js is ill formatted'
        cb()

describe 'Generator Reveal', ->
    # SUT object.
    run_context = {}

    beforeEach ->
        run_context = helpers.run(path.join __dirname, '../app')
        # do not return Promise, since we do not want to wait for it yet!
        null
    afterEach (done) ->
        lint_generated_files(done)

    context 'with defaults', ->
        beforeEach ->
            run_context

        it 'should generate dotfiles', ->
            expected = [
                '.bowerrc'
                '.editorconfig'
                '.gitignore'
                '.jshintrc'
                '.yo-rc.json'
            ]

            assert.file expected

        it 'generates expected boilerplate files', ->
            expected = [
                'gulpfile.js'
                'templates/index.html'
                'slides/index.md'
                'bower.json'
                'js/loadhtmlslides.js'
                'package.json'
                'resources/.gitkeep'
            ]

            assert.file expected

        it 'uses defaults for .yo-rc.json config', ->
            assert.fileContent '.yo-rc.json', '"courseTitle": "Developing ... with ..."'
            assert.fileContent '.yo-rc.json', 'courseCode": ""'

    it 'updates .yo-rc.json config according to prompt input', ->
        run_context
            .withPrompts(
                courseTitle: 'ICanHazConfig'
                courseCode: 'DDAS'
            )
            .on 'end', ->
                assert.fileContent '.yo-rc.json', /"@infosupport\/generator-kc"/
                assert.fileContent '.yo-rc.json', /"courseTitle": "ICanHazConfig"/
                assert.fileContent '.yo-rc.json', /"courseCode": "DDAS"/