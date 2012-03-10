Store = require('./store')

module.exports = 
  Store: Store
  store: (configFilePath,settings = {}) ->
    new Store(configFilePath,settings)