(function() {
  var Store, fs, _, _arrayify,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  fs = require('fs');

  _ = require('underscore');

  /*
  Converts an object, or null into an array. If it is already an array,
  uniques will be removed and the array will be returned.
  */

  _arrayify = function(obj) {
    if (!obj) return [];
    if (_.isArray(obj)) return _.uniq(obj);
    return [obj];
  };

  module.exports = Store = (function() {
    /*
      Initializes a new instance of the store, bound to a config file. 
      The config file needs to be a json encoded array of token strings, like so:
      ["Iamatoken","iamanothertoken"]
    */
    function Store(configFilePath, settings) {
      this.configFilePath = configFilePath;
      this.settings = settings != null ? settings : {};
      this.isValidAndInScope = __bind(this.isValidAndInScope, this);
      this.isValid = __bind(this.isValid, this);
      this._ensureConfigLoaded = __bind(this._ensureConfigLoaded, this);
      _.defaults(this.settings, {});
    }

    /*
      Internal lazy load config helper
    */

    Store.prototype._ensureConfigLoaded = function(cb) {
      var _this = this;
      if (this.tokens) return cb(null);
      return fs.readFile(this.configFilePath, 'utf8', function(err, data) {
        var loaded;
        if (err) return cb(err);
        _this.tokens = {};
        loaded = JSON.parse(data);
        _.each(loaded, function(token) {
          var name, scopes;
          if (typeof token === "string") {
            return _this.tokens[token] = [];
          } else if (typeof token === "object") {
            name = token['token'];
            scopes = token['scopes'] || [];
            if (name && name.length > 0) {
              return _this.tokens[name] = scopes;
            } else {
              throw "Unsupported token format " + (JSON.stringify(token));
            }
          } else {
            throw "Unsupported token format " + (JSON.stringify(token));
          }
        });
        return cb(null);
      });
    };

    /*
      Checks if a token is present in the store.
    */

    Store.prototype.isValid = function(token, cb) {
      var _this = this;
      return this._ensureConfigLoaded(function(err) {
        var tk;
        if (err) return cb(err);
        tk = _this.tokens[token];
        return cb(null, !!tk, tk ? tk : []);
      });
    };

    Store.prototype.isValidAndInScope = function(token, scope, cb) {
      var scopes,
        _this = this;
      scopes = _arrayify(scope);
      return this._ensureConfigLoaded(function(err) {
        var isValid, tk;
        if (err) return cb(err);
        tk = _this.tokens[token];
        isValid = !!tk;
        if (tk) {
          _.each(scopes, function(x) {
            if (!_.include(tk, x)) return isValid = false;
          });
        }
        return cb(null, isValid, tk ? tk : []);
      });
    };

    return Store;

  })();

}).call(this);
