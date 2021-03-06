Mailer Demo App
==========================

This is a simple app used to demo creating a JSON API with Sinatra. This app simply takes POST data and uses it to send an email according to the POST data it received.

This app follows the basic JSON format shown at [jsonapi.org](http://jsonapi.org/format).

In a nutshell, all returned JSON can be expect to have the following basic format:

Resource names are in the top level (emails, errors)

	{ "emails":[{...}] }

Resources are always returned inside an array (both singular and collections)

    { "emails":[{...}] }
    { "errors":[{...}, {...}] }

Usage and Set up
--------------------------

To use this app, you must make sure to set up the ENV['MANDRILL\_USER'] and ENV['MANDRILL\_API\_KEY'] variables. You can also use any other SMTP provider of your choice, such as gmail.

You can do this via the provided `secrets.rb` (see secrets.example.rb) or via something more akin Foreman's `.env` file or Fiagro's `application.yml` file

**This application will fail to launch if the environment variables are not present AND the secrets.rb file is not present. Make the appropriate modifications for your use**

For Heroku, make sure to use the `heroku config:set VAR_NAME=VAR_VALUE` command

Endpoints
-------------------------

#### POST /api/mailer

**required attributes**

**to**: The email address you want to send to  
**subject**: The subject of the email you want to send  
**body**: The body or actual message you want to send inside the email

Example of the data that should be posted:  

    { "to": "guy <yoguy@example.com>", "subject": "hello world", "body": "Hi guy! Sending you an email via this awesome API I just made on the interwebs." }

##### Returns

emails - JSON resource

**emails attributes**  
status: Status of the email message  
details: Right now, it is just the email itself, but will eventually be in a more data-consumable friendly format  

Example return data: 

    {"emails":[{"status":"Mail Sent","details":"Date: Mon, 29 Jul 2013 09:10:17 -0700\r\nFrom: do-not-reply@example.com\r\nTo: \"Bryan R.\" <bryanaka0@gmail.com>\r\nMessage-ID: <51f693e99c065_146ff3ff0114267d860458@Bryans-MacBook-Pro-3.local.mail>\r\nSubject: hello world\r\nMime-Version: 1.0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\nHi John! Sending you an email via this awesome API I just made on the interwebs."}]}

Errors
-------------------------

This app currently returns two different errors, and uses HTTP Status Codes to communicate this.

#### 400 - Bad Syntax   
  
This error basically encapsulates all the errors that come with trying to POST data that is not properly formated and/or not JSON.

#### 405 - Method Not Allowed  
  
This error occurs when you try to access the resource via a Request Method that isn't allowed.
All API calls in this app are only available through a POST request

Example:  

    {"errors":[{"message":"This resource only responses to a POST request. Please refer to the documentation"}]}

Improvements to the app that can be made
-------------------------------------------

1. Return better error messages that specify where the error occured and why
2. POST data should be similar to the data the app returns, in terms of format
3. More encapsulation via modules, classes, etc. (if this app was to grow) 
4. Test E-mail capability more throughly
