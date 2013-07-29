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

## Endpoints

#### POST /api/mailer

**required attributes**

**to**: The email address you want to send to  
**subject**: The subject of the email you want to send  
**body**: The body or actual message you want to send inside the email

Example of the data that should be posted:  

    { "to": "John G <jmondo@newrelic.com>", "subject": "hello world", "body": "Hi John! Sending you an email via this awesome API I just made on the interwebs." }

##### Returns

emails - JSON resource

**emails attributes**  
status: Status of the email message
details: Right now, it is just the email itself, but will eventually be in a more data-consumable friendly format

Example return data: 

    {"emails":[{"status":"Mail Sent","details":"Date: Mon, 29 Jul 2013 09:10:17 -0700\r\nFrom: do-not-reply@example.com\r\nTo: \"Bryan R.\" <bryanaka0@gmail.com>\r\nMessage-ID: <51f693e99c065_146ff3ff0114267d860458@Bryans-MacBook-Pro-3.local.mail>\r\nSubject: hello world\r\nMime-Version: 1.0\r\nContent-Type: text/plain;\r\n charset=UTF-8\r\nContent-Transfer-Encoding: 7bit\r\n\r\nHi John! Sending you an email via this awesome API I just made on the interwebs."}]}

## Errors


