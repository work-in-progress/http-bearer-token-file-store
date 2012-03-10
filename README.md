## About http-bearer-token-file-store

A low security file based storage for tokens that can be used to secure web services.

Imagine you have a web service that provides a set of simple auxiliary functions,
like converting from one file representation to another. It does not really
warrant full blown security system but you want to protect it anyways. This is
a good use case for this npm module, combined with Jared Hanson's bearer token module (https://github.com/jaredhanson/passport-http-bearer)

## Install

npm install http-bearer-token-file-store

## Usage (Coffeescript)
  
Create a token file (like the one on examples/config/access-tokens.json). 

	httpBearerTokenFileStore = require 'http-bearer-token-file-store'
	path = require 'path'
	
	pathToTokenFile = path.join __dirname ,"./config/access-tokens.json"
	@bearerTokenStore = httpBearerTokenFileStore.store pathToTokenFile
	
Now you can use the 

	 @bearerTokenStore.isValid token, (err,valid,scopes) ->
	 @bearerTokenStore.isValidAndInScope token,scope, (err,valid,scopes) ->

methods. The first one checks if the token exists, but does not perform a scope
check. The second one checks if the token is in the scope passed along. The scope
can be null, an string, an array of one string, an array of many strings (all must be met).

## Token File format

	[{ "token" : "some-token", "scopes" : ["http://publicschema.org/scopes/admin"]  },
	"another-token"]

The token file must be a valid json file, with an array at the root, and can consist of two kind of entries, either a simple string ("another-token") or an object with a "token" and a "scopes" property, where "token" must be a string and "scopes" an array of zero or more scopes.

When loading invalid content from a valid json file it will callback with an error.

## Check out

* https://github.com/jaredhanson/passport

for a comprehensive authentication solution for node.js

## Advertising :)

Check out 

* http://scottyapp.com

Follow us on Twitter at 

* @getscottyapp
* @martin_sunset

and like us on Facebook please. Every mention is welcome and we follow back.



## Release Notes


### 0.0.1

* First version

## Internal Stuff

* npm run-script watch

## Publish new version

* Change version in package.json
* git tag -a v0.0.1 -m 'version 0.0.1'
* git push --tags
* npm publish

## Contributing to http-bearer-token-file-store
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the package.json, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 ScottyApp, Inc. See LICENSE for
further details.


