(function() {
  var Store;

  Store = require('./store');

  module.exports = {
    Store: Store,
    store: function(configFilePath, settings) {
      if (settings == null) settings = {};
      return new Store(configFilePath, settings);
    }
  };

}).call(this);
