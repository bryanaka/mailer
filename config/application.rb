require File.expand_path('../config/boot')

Bundler.require(:default, ENV["RACK_ENV"])

configure do
	enable :logging, :dump_errors, :raise_errors
	set :root, ENV['PROJECT_ROOT']
	set :app_file, ENV['APP_ROOT']
end

require File.expand_path("../environments/" + ENV['RACK_ENV'] , __FILE__)
