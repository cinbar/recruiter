# Recruiter

A web portal for managing Job Recruitment

## Basic Setup

Make sure you are on ruby 2 locally
$ rvm use '2.0.0'

Make sure your gems are up to date
$ bundle install

Make sure your database is up to date (assumes your development database exists)

$ rake db:migrate

== Start the server
$ bundle exec thin start

Visit localhost:3000