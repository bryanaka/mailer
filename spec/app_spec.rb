require File.expand_path('../spec_helper', __FILE__)

describe app do

let(:demo_json){ { to: "John G <jmondo@newrelic.com>", subject: "hello world", body: "Hi John! Sending you an email via this awesome API I just made on the interwebs." }.to_json }

	it "should load correctly" do
		get '/hello'
		last_response.should be_ok
	end

	context "New Relic Mailer Endpoint 'api/nr_mailer' " do

		it "should respond to a get request with a 405 error" do
			get '/nr_mailer'

			last_response.status.should eq(405)
			last_response.body.should eq( {errors: [{ message: "This resource only responses to a post request. Please refer to the documentation" }] }.to_json )
		end

		it "should respond to post request with no data with an error, asking for data" do
			
			post 'api/nr_mailer'

			last_response.status.should eq(400)
			last_response.body.should eq( { errors: [{ message: "This resource requires you post JSON data with the to, subject, and body attributes." }] }.to_json )

		end

	end

end