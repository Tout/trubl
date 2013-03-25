#!/bin/sh

# bundle the gems
echo "%%% Running: bundle install %%%"
bundle install

# migrate the database (the cucumber/rspec tasks will do a db:test:prepare and parallel:prepare)
echo "%%% Running specs %%%"
bundle exec rake spec --trace
