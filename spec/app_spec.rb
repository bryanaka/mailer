require File.expand_path('../spec_helper', __FILE__)

describe "New Relic Mailer App" do

	it "should load correctly" do
		get '/hello'
		last_response.should be_ok
	end

end