#!/bin/bash

set -x

cd /usr/src/app

rm -rf tmp
rm -f log/development.log
bundle install
bundle exec rake db:create
bundle exec rake db:migrate

# if [ -n "$RAILS_ENV" ]
# then
#    if [ "$RAILS_ENV" == "production" ]
#    then
#	bundle exec rake assets:precompile
#    fi
# fi

rails server -b0.0.0.0
