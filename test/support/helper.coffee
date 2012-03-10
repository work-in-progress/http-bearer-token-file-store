fs = require 'fs'
_ = require 'underscore'
async = require 'async'

class Helper
      
  fixturePath: (fileName) =>
    "#{__dirname}/../fixtures/#{fileName}"

  tmpPath: (fileName) =>
    "#{__dirname}/../tmp/#{fileName}"

  cleanTmpFiles: (fileNames) =>
    for file in fileNames
      try
        fs.unlinkSync @tmpPath(file)
      catch ignore

  loadJsonFixture: (fixtureName) =>
    data = fs.readFileSync @fixturePath(fixtureName), "utf-8"
    JSON.parse data

      
  start: (obj = {}, done) =>
    _.defaults obj, { }

    stuff = []

    async.series stuff, () => done()
    
  stop: (done) =>
    # Should probably drop database here
    done()

module.exports = new Helper()

