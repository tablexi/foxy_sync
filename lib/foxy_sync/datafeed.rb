require 'rc4'
require 'cgi'

module FoxySync
  #
  # Holds methods that help with FoxyCart's datafeed
  # requests (http://wiki.foxycart.com/v/1.0/webhooks).
  # This module is typically mixed into a controller.
  module Datafeed

    #
    # Handles the decoding and decrypting of a datafeed request.
    # Returns a +FoxySync::Api::Response+ whose document is the datafeed XML
    #[_params_]
    #  Something that responds_to? [] and has a key 'FoxyData'. In Rails
    #  that would be the +params+ object
    def datafeed_unwrap(params)
      encrypted = params['FoxyData']
      rc4 = RC4.new FoxySync.api_key
      xml = rc4.decrypt CGI::unescape(encrypted)
      FoxySync::Api::Response.new xml
    end


    #
    # Retrieves custom product options from +api_response+
    # and returns them in a +Hash+ of 'name' => 'value'
    # [_api_response_]
    #   The return of #datafeed_unwrap
    def datafeed_custom_product_options(api_response)
      options = {}
      options_xml = api_response.document.xpath('//transaction_detail_option')

      options_xml.each do |node|
        name = node.at_css('product_option_name').content.strip
        value = node.at_css('product_option_value').content.strip
        options[name] = value
      end

      options
    end


    #
    # Wrapper for the text reply that a datafeed request expects
    def datafeed_response
      'foxy'
    end

  end
end