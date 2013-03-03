module FoxySync
  autoload :Sso,            'foxy_sync/sso'
  autoload :Datafeed,       'foxy_sync/datafeed'
  autoload :CartValidation, 'foxy_sync/cart_validation'

  module Api
    autoload :Messenger,         'foxy_sync/api/messenger'
    autoload :Response,          'foxy_sync/api/response'
    autoload :Base,              'foxy_sync/api/base'
    autoload :Customer,          'foxy_sync/api/customer'
    autoload :NodeResponder,     'foxy_sync/api/node_responder'
    autoload :TransactionDetail, 'foxy_sync/api/transaction_detail'
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
