'use strict'

assert = require 'assert'

describe 'Generator Reveal', ->
    it 'can be imported without blowing up', ->
        app = require '../app'
        assert.equal !!app, true