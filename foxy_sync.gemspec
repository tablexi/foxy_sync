Gem::Specification.new do |s|
  s.name        = 'foxy_sync'
  s.version     = '0.1.0'
  s.homepage    = 'https://github.com/tablexi/foxy_sync'
  s.summary     = 'Synchronizes your Ruby application with FoxyCart'
  s.description = 'Encapsulates FoxyCart SSO, Datafeed, and cart validation protocols'
  s.authors     = ['Chris Stump']
  s.email       = 'chris@tablexi.com'
  s.files       = Dir[ File.expand_path './foxy_sync/lib/**/*', File.dirname(__FILE__) ]

  s.add_dependency 'nokogiri', [ '~> 1.5.5' ]
  s.add_development_dependency 'rspec', [ '~> 2.11.0' ]
end
