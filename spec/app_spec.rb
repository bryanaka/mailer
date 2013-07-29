require File.expand_path('../spec_helper', __FILE__)

describe app do

	let(:demo_json){ { to: "bryanaka0@gmail.com", subject: "hello world", body: "Hi John! Sending you an email via this awesome API I just made on the interwebs." }.to_json }
	let(:json_format){ 'application/json;charset=utf-8' }
	let(:error_405){ { errors: [{ message: 'This resource only responses to a POST request. Please refer to the documentation' }] }.to_json }
	let(:error_400){ { errors: [{ message: 'This resource requires you post JSON data with the "to", "subject", and "body" attributes.' }] }.to_json }

	it "should not serve json to anything not under api" do
		get '/hello'

		last_response.should be_ok
		last_response.content_type.should_not eq(json_format)
	end

	it "#email helper method sends email" do
		email_data = JSON.parse(demo_json)
		email(email_data).should be_true
	end

	describe "New Relic Mailer Endpoint 'api/nr_mailer' " do

		context "has a malformed request" do

			it "should respond to a get request with a 405 error" do
				get '/api/nr_mailer'

				last_response.status.should eq(405)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_405 )
			end
	
			it "should respond to post request with no data with an error, asking for data" do
				post '/api/nr_mailer'
	
				last_response.status.should eq(400)
				last_response.content_type.should eq(json_format)
				last_response.body.should eq( error_400 )
			end

			it "return an error if the data sent in the body is not JSON data" do
				post '/api/nr_mailer', 'yo dawg whats up'

				last_response.status.should eq(400)
				last_response.body.should eq( error_400 )
			end

		end

		context "has a correctly formated request" do

			it "should recieve JSON data" do
				post '/api/nr_mailer', demo_json
				last_response.should be_ok
			end

			it "should send an email according to the data sent in json" do
				pending
			end

		end

	end

end