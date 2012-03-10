fs = require('fs')
_ = require 'underscore'

###
Converts an object, or null into an array. If it is already an array,
uniques will be removed and the array will be returned.
###
_arrayify = (obj) ->
  return [] unless obj
  return _.uniq(obj) if _.isArray obj
  [obj]
  
  
module.exports = class Store
  ###
  Initializes a new instance of the store, bound to a config file. 
  The config file needs to be a json encoded array of token strings, like so:
  ["Iamatoken","iamanothertoken"]
  ###
  constructor: (@configFilePath,@settings = {}) ->
    _.defaults @settings, {}
  
  ###
  Internal lazy load config helper
  ###
  _ensureConfigLoaded: (cb) =>
    return cb null if @tokens
    
    fs.readFile  @configFilePath ,'utf8',(err, data) =>
      return cb(err) if err
      
      @tokens = {}
      loaded = JSON.parse(data)
      _.each loaded, (token) =>
        if typeof token is "string"
          @tokens[token] = []
        else if typeof token is "object"
          name = token['token']
          scopes = token['scopes'] || []
          if name && name.length > 0
            @tokens[name] = scopes
          else
            throw "Unsupported token format #{JSON.stringify(token)}"
        else
          throw "Unsupported token format #{JSON.stringify(token)}"
          
      cb null
    
  ###
  Checks if a token is present in the store.
  ###    
  isValid: (token,cb) =>
    @_ensureConfigLoaded (err) =>
      return cb err if err

      tk =  @tokens[token]
      cb null, !! tk, if tk then tk else [] 

  isValidAndInScope: (token,scope,cb) =>
    scopes = _arrayify(scope)
    
    @_ensureConfigLoaded (err) =>
      return cb err if err
      #cb null, !!_.include(@tokens,token)
      tk =  @tokens[token]
      
      isValid = !!tk
      
      if tk
        _.each scopes, (x) ->
          isValid = false unless _.include tk, x
      
      cb null, isValid, if tk then tk else [] 
