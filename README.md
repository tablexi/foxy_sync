FoxySync
=========

A gem to synchronize your Ruby application with FoxyCart.

It encapsulates the [FoxyCart](http://foxycart.com) [SSO](http://wiki.foxycart.com/v/1.0/sso),
[Datafeed](http://wiki.foxycart.com/v/1.0/transaction_xml_datafeed), and
[cart validation](http://wiki.foxycart.com/v/1.0/hmac_validation) protocols and abstracts the
entire [FoxyCart API](http://wiki.foxycart.com/v/1.0/api).


Installation
------------

If you use [Bundler](http://gembundler.com/) just add ```gem 'foxy_sync'``` to your Gemfile and
then run ```bundle install```. Otherwise you can ```gem install foxy_sync``` manually.


Setup
-----------

You'll need to configure FoxySync before you can start using it. At the very least you should
set your FoxyCart API key and store URL:

```
FoxySync.setup do |config|
  config.api_key = 'YOUR API KEY HERE'
  config.store_url = 'YOUR STORE URL HERE'
end
```

You should do this in an application startup file. In Rails, for example, it's best to put it in
a file ```config/initializers/foxy_sync.rb```


Cart validation
--------------------

FoxySync provides methods for creating form inputs that will validate with
[FoxyCart's cart validation service](http://wiki.foxycart.com/v/1.0/hmac_validation). To create a hidden
input like this:

```<input type="hidden" value="mai" name="code||5651608dde5a2abeb51fad7099fbd1a026690a7ddbd93a1a3167362e2f611b53"/>```

You would ```include FoxySync::CartValidation``` and output your hidden field with a name whose value is
```input_name 'code', 'mai', 'mai'```


Single Sign On
--------------

FoxySync provides methods for creating the URL applications redirect to during the
[FoxyCart single sign on service handshake](http://wiki.foxycart.com/v/1.0/sso).

To get the redirect URL just ```include FoxySync::Sso``` and ```redirect_to sso_url(params, user)```.
The params argument should be something that responds to [] and holds the 'fcsid' and 'timestamp' parameters
given by the FoxyCart SSO request (in Rails that's the ```params``` object). The user argument should be the
currently logged in user, if any.


XML Datafeeds
-------------

It's in the works!


FoxyCart API
------------

You can access any part of the [FoxyCart API](http://wiki.foxycart.com/v/1.0/api) via the ```FoxySync::Api::Messenger```
class. To use it create a new instance and then send it a message that corresponds to the FoxyCart API. All messages
return an instance of ```FoxySync::Api::Response``` through which you can access FoxyCart's XML response. For Example:
```
    api = FoxySync::Api::Messenger.new
    reply = api.customer_get :customer_email => 'foo@bar.com'
    reply.customer_id # is the customer's FoxyCart id
```
```Messenger``` instances respond to every API call in FoxyCart v1.0.