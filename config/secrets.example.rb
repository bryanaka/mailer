# This page should hold anything that needs to be secret
# Usually, this is placed in something more akin to the application.yml file via the figaro gem
# or can also be placed into your environment via limitless other methods
# but this will work for now as a MVP

ENV['MANDRILL_USER'] 		||= 'username'
ENV['MANDRILL_API_KEY'] ||= 'api_key'