module FoxySync::Api
  #
  # Intended for subclassing, +Base+ forms the foundation
  # for ::Api:: classes that wrap a +FoxySync::Xml::Document+
  # composed of API reply XML to provide behavior around
  # specific elements
  class Base
    attr_reader :api_response

    #
    # [_api_response_]
    #   A +FoxySync::Xml::Document+ that holds API reply XML
    def initialize(api_response)
      @api_response = api_response
    end

    #
    # Delegates to #api_response
    def respond_to?(method_name, include_private = false)
      super || api_response.respond_to?(method_name, include_private)
    end


    private

    def method_missing(method_name, *args, &block)
      api_response.send method_name, *args
    end


    def messenger
      @_messenger ||= FoxySync::Api::Messenger.new
    end
  end
end