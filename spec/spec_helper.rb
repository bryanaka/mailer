ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../app', __FILE__)
require 'rack/test'
require 'email_spec'

RSpec.configure do |config|
	config.include Rack::Test::Methods
	config.include EmailSpec::Helpers
	config.include EmailSpec::Matchers

	def app
	  Sinatra::Application
	end
	
end
