# Recruiter

A web portal for managing Job Recruitment

## Basic Setup
Make sure you are on ruby 2 locally
`$ rvm use '2.0.0'`

Make sure your gems are up to date
`$ bundle install`

Rename 'config/database.yml.example' => '/config/database.yml'
DO NOT check it into version control (should be in /.gitignore)

Make sure your database is up to date (assumes your development database exists)
`$ rake db:migrate`

## Run Locally
`$ bundle exec thin start`

Visit `localhost:3000`
