require File.expand_path('../config/boot', __FILE__)

error 405 do
	{errors: [{ message: "This resource only responses to a post request. Please refer to the documentation" }] }.to_json
end

before '/api/*' do
	content_type :json
	if request.request_method == 'GET'
		halt 405
	end
end

get '/hello' do
	'What up dawg'
end

post '/api/nr_mailer' do
	'hello api'
end
