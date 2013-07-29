require File.expand_path('../config/boot', __FILE__)

# Bad Request (used for a request that isn't formed correctly)
error 400 do
  {errors: [{ message: 'This resource requires you post JSON data with the "to", "subject", and "body" attributes.' }] }.to_json
end

# Wrong HTTP Verb
error 405 do
  {errors: [{ message: 'This resource only responses to a POST request. Please refer to the documentation' }] }.to_json
end

# ensures that the content type is JSON and the Request is POST
before '/api/*' do
  content_type :json
  if request.request_method != 'POST'
    halt 405
  end
end

# Mailers in their own module so it can be tested
module Mailers

  def email(request_data)
    mail_options = {
      :to       => request_data["to"],
      :from     => 'noreply@example.com',
      :subject  => request_data["subject"],
      :body     => request_data["body"],
      :via      => :smtp,
      :via_options => {
        :address => 'smtp.gmail.com', # 'smtp.mandrillapp.com'
        :enable_starttls_auto => true,
        :port => '587',
        :user_name => ENV['GMAIL_USER'], # ENV['MANDRILL_USER'],
        :password => ENV['GMAIL_PASSWORD'], # ENV['MANDRILL_API_KEY'],
        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain => "http://nr-mailer.herokuapp.com/" 
      }
    }
    Pony.mail(mail_options)
  end

end

helpers Mailers

get '/hello' do
  'What up dawg'
end

post '/api/mailer' do
  # read the body into a json_data
  request.body.rewind
  json_data = request.body.read

  # begin parsing the data
  begin
    request_data = JSON.parse(json_data)
  rescue JSON::ParserError
    halt 400
  end

  # if any of the required parameters are not present, return 400 error
  if !request_data['to'] || !request_data['subject'] || !request_data['body']
    halt 400
  end

  # send the email
  mail_response = email(request_data)

  # send 201 created status with json response.
  status 201
  {:emails => [{ :status => 'Mail Sent', :details => mail_response }] }.to_json
end
