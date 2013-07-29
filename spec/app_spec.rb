require File.expand_path('../spec_helper', __FILE__)

describe app do

	let(:demo_json){ { to: 'bryanaka0@gmail.com', subject: 'hello world', body: 'Hi John! Sending you an email via this awesome API I just made on the interwebs.' }.to_json }
	let(:json_format){ 'application/json;charset=utf-8' }
	let(:error_405){ { errors: [{ message: 'This resource only responses to a POST request. Please refer to the documentation' }] }.to_json }
	let(:error_400){ { errors: [{ message: 'This resource requires you post JSON data with the "to", "subject", and "body" attributes.' }] }.to_json }

	it "should not serve json to anything not under api" do
		get '/hello'

		last_response.should be_ok
		last_response.content_type.should_not eq(json_format)
	end

	it "#email helper method sends email" do
		# Seems hacky, but the only way I knew how to properly test the helper modules
		# Definitely needs to get refactored

		# This allows use of the modules' public instance methods
		Mailers.extend Mailers
		# Call email wth the demo_json
		response = Mailers.send(:email, JSON.parse(demo_json))

		response.should_not be_empty

	end

	describe "New Relic Mailer Endpoint 'api/mailer' " do

		context "has a malformed request" do

			it "should respond to a get request with a 405 error" do
				get '/api/mailer'

				last_response.status.should eq(405)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_405 )
			end
	
			it "should respond to post request with no data with an error, asking for data" do
				post '/api/mailer'
	
				last_response.status.should eq(400)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_400 )
			end

			it "returns an error if the data sent in the body is not JSON data" do
				post '/api/mailer', 'yo dawg whats up'

				last_response.status.should eq(400)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_400 )
			end

			it "shold return an error if not all parameters are supplied" do
				post 'api/mailer', {to: "bryanaka0@gmail.com"}.to_json

				last_response.status.should eq(400)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_400 )
			end

		end

		context "has a correctly formated request" do

			it "should recieve JSON data and send the email" do
				post '/api/mailer', demo_json
				last_response.status.should eq(201)
			end

		end

	end

end