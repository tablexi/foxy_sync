Gem::Specification.new do |s|
  s.name        = 'foxy_sync'
  s.version     = '0.3.2'
  s.homepage    = 'https://github.com/tablexi/foxy_sync'
  s.summary     = 'Synchronizes your Ruby application with FoxyCart'
  s.description = 'Encapsulates FoxyCart SSO, datafeed, and cart validation protocols'
  s.authors     = ['Chris Stump']
  s.email       = 'chris@tablexi.com'

  cur_dir = File.expand_path('.', File.dirname(__FILE__))
  s.files       = Dir[ File.join(cur_dir, './lib/**/*') ].each {|f| f.gsub!("#{cur_dir}/", '') }

  s.add_dependency 'nokogiri', [ '> 1.5.5' ]
  s.add_dependency 'ruby-rc4', [ '~> 0.1.5' ]
  s.add_development_dependency 'rspec', [ '~> 2.11.0' ]
end
