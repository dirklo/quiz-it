source 'http://rubygems.org'

ruby "2.6.1"

gem 'sinatra'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'bcrypt'
gem 'rack-flash3'
gem 'rack'

group :development do
  gem 'tux'
  gem 'shotgun'
  gem 'pry'
  gem 'sqlite3', '~> 1.3.6'
  gem 'dotenv'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
