#!/bin/bash
[[ -s "/home/jba/.rvm/scripts/rvm" ]] && source "/home/jba/.rvm/scripts/rvm"
rvm use 1.9.3

cd git/trubl
source tout_test_vars.txt
bundle install
bundle exec ruby bin/trubl_loadtest.rb
