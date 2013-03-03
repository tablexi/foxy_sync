require 'nokogiri'

module FoxySync::Api
  #
  # A +Response+ represents an XML reply
  # sent by the FoxyCart API. To use it simply
  # send an instance a message that corresponds
  # to an element in the XML. For example,
  #
  # api = FoxySync::Api::Messenger.new
  # reply = api.customer_get :customer_email => 'foo@bar.com'
  # reply.customer_id # is the customer's FoxyCart id
  class Response < NodeResponder
    #
    # The raw XML used to create this +Response+
    attr_reader :xml


    def initialize(xml)
      @xml = xml
      super Nokogiri::XML(xml) {|config| config.strict.nonet }
    end
  end
end