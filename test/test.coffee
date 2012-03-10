should = require 'should'

helper = require './support/helper'
index = require '../lib/index'        

describe 'WHEN working with the plugin', ->
  before (done) ->
    helper.start null, done
  after ( done) ->
    helper.stop done

  describe 'index', ->
    it 'should exist', (done) ->
      should.exist index
      done()

 