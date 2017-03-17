'use strict'

path = require 'path'
Generator = require 'yeoman-generator'
semver = require 'semver'
chalk = require 'chalk'
slugify = require 'underscore.string/slugify'
capitalize = require 'underscore.string/capitalize'
_ = require 'lodash'

module.exports = class RevealGenerator extends Generator
    initializing: ->
        @pkg = @fs.readJSON path.join __dirname, '../package.json'

        # Setup config defaults.
        @config.defaults
            courseTitle: 'Developing ... with ...'
            courseCode: ''

    prompting:
        askFor: ->
            prompts = [
                {
                    name: 'courseTitle'
                    message: 'What are you going to talk about?'
                    default: @config.get 'courseTitle'
                }
                {
                    name: 'courseCode'
                    message: 'What is the course code?'
                    default: @config.get 'courseCode'
                }
            ]
            @prompt(prompts).then (props) =>
                # Write answers to `config`.
                @config.set 'courseTitle', props.courseTitle
                @config.set 'courseCode', props.courseCode

    writing:
        app: ->
            @fs.copyTpl @templatePath('_!help.md'), @destinationPath('slides/!help.md'), @
            @fs.copyTpl @templatePath('_00-title.md'), @destinationPath('slides/00-title.md'), @
            @fs.copyTpl @templatePath('gulpfile.js'), @destinationPath('gulpfile.js'), @

            @fs.copyTpl @templatePath('_package.json'), @destinationPath('package.json'), {slugify: slugify, config: @config}
            @fs.copyTpl @templatePath('_bower.json'), @destinationPath('bower.json'), {slugify: slugify, config: @config}
            @fs.copy @templatePath('loadhtmlslides.js'), @destinationPath('js/loadhtmlslides.js')

            @fs.copyTpl @templatePath('_index.html'), @destinationPath('templates/index.html'), {'_': _, capitalize: capitalize, config: @config}

            @fs.write @destinationPath('resources/.gitkeep'), 'Used to store static assets'

        projectfiles: ->
            @fs.copy @templatePath('editorconfig'), @destinationPath('.editorconfig')
            @fs.copy @templatePath('jshintrc'), @destinationPath('.jshintrc')

        runtime: ->
            @fs.copy @templatePath('bowerrc'), @destinationPath('.bowerrc')
            @fs.copy @templatePath('gitignore'), @destinationPath('.gitignore')

    install: ->
        @installDependencies skipInstall: @options['skip-install']
