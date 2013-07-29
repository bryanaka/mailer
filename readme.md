Mailer Demo App
==========================

This is a simple app used to demo creating a JSON API with Sinatra. This app simply takes POST data and uses it to send an email according to the POST data it recieved.

## Endpoints

#### POST /api/mailer

**required attributes**

**to**: The email address you want to send to  
**subject**: The subject of the email you want to send  
**body**: The body or actual message you want to send inside the email 

Example of the data that should be posted:  

    { "to": "John G <jmondo@newrelic.com>", "subject": "hello world", "body": "Hi John! Sending you an email via this awesome API I just made on the interwebs." }


