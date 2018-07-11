

require 'bundler/setup'
require 'active_record'
require 'require_all'

require_all 'app'

Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
    ENV['SINATRA_ENV'] ||= "development"
    ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
    )
end

configure :production do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
end
