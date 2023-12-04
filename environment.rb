require 'bundler/setup'
require 'dotenv'

Dotenv.load

APP_ENV=ENV['APP_ENV'] || 'development'

Bundler.require(:default, APP_ENV)

ActiveRecord::Base.establish_connection(YAML.load_file("db/config.yml")[APP_ENV])

Zeitwerk::Loader.new.tap do |loader|
  loader.push_dir("lib")
  loader.push_dir("app/workers")
  loader.push_dir("app/models")
  loader.push_dir("app/services")
  loader.setup
  loader.eager_load
end
