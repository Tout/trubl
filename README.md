# Trubl

A Ruby 1.9 interface for the Tout API. Right now, the read only API calls have been implemented, 
but given proper user auth implementation, the infrastructure is ready for writing back as well.

Intended as sample code initially, help take it to greatness!

See http://developer.tout.com/ and https://github.com/Tout/trubl for details.

# Using Trubl

## Installation
```sh
bundle install
```

## Run unit tests
```sh
bundle exec rspec -d -f d
```

## Run sample script with valid app credentials
```sh
export CLIENT_ID=#{your client id}
export CLIENT_SECRET=#{your client secret}
export CALLBACK_URL=#{your callback url}
bundle exec ruby bin/trubl_sample
```

## Use a client instance
Get a client instance, and authenticate with tout.com:
```rb
client = Trubl.client('client_id', 'client_secret')
client.auth()
# or
client = Trubl::Client.new('client_id', 'client_secret')
client.auth()
```

Search for users matching a keyword
```rb
collection = client.search_users('aaron', 2, 4)
collection.pagination
# => hash of pagination data
collection.users
# => get an array of Trubl::User instances
```

etc, etc

## Contributing to trubl
 
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2013 Aaron Terrell, Tout. See LICENSE.txt for
further details.

