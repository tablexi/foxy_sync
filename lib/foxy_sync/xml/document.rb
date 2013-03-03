require 'nokogiri'

module FoxySync::Xml
  #
  # Encapsulates a FoxyCart XML doc. To use it simply send a
  # message that corresponds to an element in the XML. For example,
  #
  # api = FoxySync::Api::Messenger.new
  # reply = api.customer_get :customer_email => 'foo@bar.com'
  # reply.customer_id # is the customer's FoxyCart id
  class Document < Base
    #
    # The raw XML used to create this +Document+
    attr_reader :xml


    def initialize(xml)
      @xml = xml
      super Nokogiri::XML(xml) {|config| config.strict.nonet }
    end
  end
end