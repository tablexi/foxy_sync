FoxySync
=========

A gem to synchronize your Ruby application with FoxyCart.

It encapsulates the [FoxyCart](http://foxycart.com) [SSO](http://wiki.foxycart.com/v/1.0/sso),
[Datafeed](http://wiki.foxycart.com/v/1.0/transaction_xml_datafeed), and
[form validation](http://wiki.foxycart.com/v/1.0/hmac_validation) protocols.


Installation
------------

If you use [Bundler](http://gembundler.com/) just add ```gem 'foxy_sync'``` to your Gemfile and
then run ```bundle install```. Otherwise you can ```gem install foxy_sync``` manually.


Setup
-----------

You'll need to configure FoxySync before you can start using it. At the very least you should
set your FoxyCart API key:

```FoxySync.api_key = 'YOUR API KEY HERE'```

You should do this in an application startup file. In Rails, for example, it's best to create a
file ```config/initializers/foxy_sync.rb``` with the following:

```
FoxySync.setup do |config|
  config.api_key = 'YOUR API KEY HERE'
end
```


HMAC form validation
--------------------

FoxySync provides helpers for creating form inputs that will validate against [FoxyCart's HMAC
form validation feature](http://wiki.foxycart.com/v/1.0/hmac_validation). To create a hidden
input like this:

```<input type="hidden" value="mai" name="code||5651608dde5a2abeb51fad7099fbd1a026690a7ddbd93a1a3167362e2f611b53"/>```

You would ```include FoxySync::Form``` and output your hidden field with a name whose value is
```input_name 'code', 'mai', 'mai'```



Single Sign On
--------------



XML Datafeeds
-------------



