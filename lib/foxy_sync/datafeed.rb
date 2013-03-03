require 'rc4'
require 'cgi'

module FoxySync
  #
  # Holds methods that help with FoxyCart's datafeed
  # requests (http://wiki.foxycart.com/v/1.0/webhooks).
  # This module is typically mixed into a controller.
  module Datafeed

    #
    # Handles the decoding and decrypting of a datafeed.
    # Returns a +FoxySync::Xml::Document+ whose #xml is the datafeed XML
    #[_params_]
    #  Something that responds_to? [] and has a key 'FoxyData'. In Rails
    #  that would be the +params+ object
    def datafeed_unwrap(params)
      encrypted = params['FoxyData']
      rc4 = RC4.new FoxySync.api_key
      xml = rc4.decrypt CGI::unescape(encrypted)
      FoxySync::Xml::Document.new xml
    end


    #
    # Wrapper for the text reply that a datafeed request expects
    def datafeed_response
      'foxy'
    end

  end
end