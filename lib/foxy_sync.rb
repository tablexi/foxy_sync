module FoxySync
  autoload :Sso,            'foxy_sync/sso'
  autoload :Datafeed,       'foxy_sync/datafeed'
  autoload :CartValidation, 'foxy_sync/cart_validation'

  module Api
    autoload :Base,      'foxy_sync/api/base'
    autoload :Customer,  'foxy_sync/api/customer'
    autoload :Messenger, 'foxy_sync/api/messenger'
  end

  module Xml
    autoload :Base,              'foxy_sync/xml/base'
    autoload :Document,          'foxy_sync/xml/document'
    autoload :Transaction,       'foxy_sync/xml/transaction'
    autoload :TransactionDetail, 'foxy_sync/xml/transaction_detail'
  end


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
