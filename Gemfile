source 'http://rubygems.org'
source 'http://iser-wdev.essex.ac.uk:8808'

gem 'rails', '4.0.1'
gem 'pg'
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 2.3.0'
gem 'coffee-rails', '~> 4.0.1'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby, require: 'v8'
gem 'jquery-rails'
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem "factory_girl_rails", "~> 4.3.0"
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'autotest'
  gem 'autotest-rails'
  gem 'autotest-growl'
  gem 'autotest-fsevent'
  gem 'ZenTest', '~> 4.9.5'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'railroady'
  gem 'capistrano', '~> 2.15.5'
end

gem 'chronic'
gem 'activeresource', require: 'active_resource'
gem 'iserfrontend-rails', '0.0.9', github: 'paulgroves/iserfrontend-rails'
# gem 'iserfrontend-rails', path: '~/github/iserfrontend-rails'
gem 'iser_auth', '0.1.7'
gem 'tire', '~> 0.6.1'
gem 'haml-rails'
gem "paperclip", "~> 3.5.2"
gem 'redcarpet'
gem 'albino'
gem 'nokogiri'
gem 'will_paginate', '~> 3.0.5'

group :production do
  gem 'passenger'
  gem 'exception_notification', "~> 4.0.1"
end

