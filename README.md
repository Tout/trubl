# tout

A Ruby interface for the Tout API. Intended as sample code initially, help take it to greatness!

See http://developer.tout.com/ for details.

# Using tout

## Installation
```sh
bundle install
```

## Run unit tests
```sh
bundle exec rspec -d -f d
```

## Use a client instance
Get a client instance, and authenticate with tout.com:
```rb
client = Tout.client('client_id', 'client_secret')
client.auth()
# or
client = Tout::Client.new('client_id', 'client_secret')
client.auth()
```

Search for users matching a keyword
```rb
collection = client.search_users('aaron', 2, 4)
collection.pagination  # hash of pagination data
collection.users       # get an array of Tout::User instances
```

etc, etc

## Contributing to tout
 
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2012 Aaron Terrell, Tout. See LICENSE.txt for
further details.

