# set Rack Environment to development if not set
ENV['RACK_ENV'] ||= 'development'

# bring in rubygems and native json 
require 'rubygems'
require 'json'

# Set up the load paths for the gems using Bundler
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

# setup the gem load paths
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# This would be nice, but Sinatra-contrib is somewhat heavy and I only need specific helpers
# Bundler.require(:default, ENV["RACK_ENV"])

require 'sinatra'
require 'sinatra/json'
require 'pony'

# auto-require the correct gem group
Bundler.require(ENV["RACK_ENV"])

# if the environment variables already exist, do not load them
if !ENV['GMAIL_USER'] || !ENV['MANDRILL_USER']
  # This could also go into a YAML file, ala Figaro Gem style
  require File.expand_path('../secrets', __FILE__)
end

# general config

configure do
  set :root, File.expand_path('../../', __FILE__)
  set :app_file, File.expand_path('../../app', __FILE__)
end

# environment specific config
# can split these off into separate files if needed, but not worth it at this level of application complexity
# require File.expand_path('../environments/' + ENV['RACK_ENV'] , __FILE__)

configure :development, :test do
  enable :logging, :dump_errors, :raise_errors
end

