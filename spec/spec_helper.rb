require 'rspec'
require File.expand_path '../lib/foxy_sync.rb', File.dirname(__FILE__)

RSpec.configure do |config|
 # Run specs in random order to surface order dependencies. If you find an
 # order dependency and want to debug it, you can fix the order by providing
 # the seed, which is printed after each run.
 #     --seed 1234
 config.order = "random"
end

FoxySync.setup do |config|
  config.api_key = 'HmLQaeEcNMtY6NCswCCIYp'
  config.store_url = 'https://foxysync.foxycart.com'
end