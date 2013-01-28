module FoxySync
  autoload :Form, 'foxy_sync/form'
  autoload :Sso, 'foxy_sync/sso'
  autoload :Api, 'foxy_sync/api'
  autoload :Datafeed, 'foxy_sync/datafeed'


  def self.setup
    yield self
  end


  @@api_key = nil

  def self.api_key=(key)
    @@api_key = key
  end

  def self.api_key
    @@api_key
  end


  @@store_url = nil

  def self.store_url=(url)
    @@store_url = url
  end

  def self.store_url
    @@store_url
  end

end
