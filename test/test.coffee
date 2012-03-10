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

  describe 'working with a valid token file', ->
    describe 'when accessing a string token (no scope)', ->
      describe 'isvalid', ->
        it 'should be ok', (done) ->
          store = index.store helper.fixturePath('good-token-file.json')
          should.exist store
      
          store.isValid 'another-token', (err,isValid,scopes) ->
            return done err if err
        
            isValid.should.equal true
            should.exist scopes
            scopes.should.be.an.instanceof Array
            scopes.should.have.lengthOf(0)
        
            done()

      describe 'isValidAndInScope', ->
        it 'should be ok when queries against null scope', (done) ->
          store = index.store helper.fixturePath('good-token-file.json')
          should.exist store

          store.isValidAndInScope 'another-token', null, (err,isValid,scopes) ->
            return done err if err

            isValid.should.equal true
            should.exist scopes
            scopes.should.be.an.instanceof Array
            scopes.should.have.lengthOf(0)
            done()

        it 'should be ok when queries against [] scope', (done) ->
          store = index.store helper.fixturePath('good-token-file.json')
          should.exist store

          store.isValidAndInScope 'another-token', [], (err,isValid,scopes) ->
            return done err if err

            isValid.should.equal true
            should.exist scopes
            scopes.should.be.an.instanceof Array
            scopes.should.have.lengthOf(0)
            done()
 
        it 'should NOT be ok when queries against "somescope" scope', (done) ->
          store = index.store helper.fixturePath('good-token-file.json')
          should.exist store

          store.isValidAndInScope 'another-token', "somescope", (err,isValid,scopes) ->
            return done err if err

            isValid.should.equal false
            should.exist scopes
            scopes.should.be.an.instanceof Array
            scopes.should.have.lengthOf(0)
            done()

  describe 'when accessing a  token (with scopes)', ->
    describe 'isvalid', ->
      it 'should be ok', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValid 'some-token', (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal true
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)

          done()

    describe 'isValidAndInScope', ->
      it 'should be ok when queries against null scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', null, (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal true
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()

      it 'should be ok when queries against [] scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', [], (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal true
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()

      it 'should NOT be ok when queries against "somescope" scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', "somescope", (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal false
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()

      it 'should be ok when queries against ["scopea"] scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', ["scopea"], (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal true
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()

      it 'should be ok when queries against ["scopea","scopeb"] scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', ["scopea","scopeb"], (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal true
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()
          
      it 'should NOT be ok when queries against ["scopea","scopeb","scopec"] scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', ["scopea","scopeb","scopec"], (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal false
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()


      it 'should NOT be ok when queries against ["scopec"] scope', (done) ->
        store = index.store helper.fixturePath('good-token-file.json')
        should.exist store

        store.isValidAndInScope 'some-token', ["scopec"], (err,isValid,scopes) ->
          return done err if err

          isValid.should.equal false
          should.exist scopes
          scopes.should.be.an.instanceof Array
          scopes.should.have.lengthOf(2)
          done()

