source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.13'

gem 'pg'
gem 'haml'
gem 'jquery-rails'
gem 'thin'
gem 'redcarpet'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem "twitter-bootstrap-rails"
end

group :development do
  gem 'foreman'
  gem 'sqlite3'
  gem 'brakeman'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  # Use poltergeist for browser tests with JavaScript.
  # It's a headless WebKit, provided by PhantomJS, which is available for all platforms.
  # See https://github.com/jonleighton/poltergeist/tree/v1.4.1#installing-phantomjs
  # Easy installation on ubuntu http://www.joyceleong.com/log/installing-phantomjs-on-ubuntu
  gem 'poltergeist', github: 'jonleighton/poltergeist', ref: '24e154a14719a4490437beb193388a242b518d43'
  gem 'database_cleaner'
  gem 'launchy'
end
