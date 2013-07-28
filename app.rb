require File.expand_path('../config/boot', __FILE__)

# Bad Request (used for a request that isn't formed correctly)
error 400 do
	{errors: [{ message: 'This resource requires you post JSON data with the "to", "subject", and "body" attributes.' }] }.to_json
end

# Wrong HTTP Verb
error 405 do
	{errors: [{ message: 'This resource only responses to a POST request. Please refer to the documentation' }] }.to_json
end

before '/api/*' do
	content_type :json
	if request.request_method != 'POST'
		halt 405
	end
end

get '/hello' do
	'What up dawg'
end

post '/api/nr_mailer' do
	request.body.rewind
	request_data = request.body.read
	if request_data != ''
		json_data = JSON.parse(request_data)
	else
		halt 400
	end
end
