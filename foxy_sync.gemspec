Gem::Specification.new do |s|
  s.name        = 'foxy_sync'
  s.version     = '1.0.0'
  s.summary     = 'Synchronizes your Ruby application with FoxyCart'
  s.description = 'Encapsulates FoxyCart SSO, Datafeed, and cart validation protocols'
  s.authors     = ['Chris Stump']
  s.email       = 'chris@mightyvites.com'
  s.files       = [ 'lib/foxy_sync.rb' ]
  s.homepage    = 'http://rubygems.org/gems/foxy_sync'

  s.add_dependency 'nokogiri', [ '~> 1.5.5' ]
  s.add_development_dependency 'rspec', [ '~> 2.11.0' ]
end
