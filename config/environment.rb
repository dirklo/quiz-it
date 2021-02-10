require 'dotenv'
Dotenv.load

ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require 'rack-flash'
require 'rack'

configure :development do
  set :database, 'sqlite3:db/development.sqlite'
end

configure :production do
  set :database, ENV['DATABASE_URL']
end

require_all 'app'