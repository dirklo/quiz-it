ENV['QUIZ_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['QUIZ_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['QUIZ_ENV']}.sqlite"
) 

require_all 'app'