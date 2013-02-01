module FoxySync::Api
  #
  # Intended for subclassing, +Base+ forms the foundation
  # for ::Api:: classes that wrap an ::Api::Response object
  # to provide behavior around specific data in the +Response+
  class Base
    attr_accessor :api_response

    #
    # [_api_response_]
    #   A +FoxySync::Api::Response+ instance
    def initialize(api_response)
      self.api_response = api_response
    end

    #
    # Delegates to #api_response
    def respond_to?(method_name, include_private = false)
      api_response.respond_to? method_name, include_private
    end


    private

    def method_missing(method_name, *args, &block)
      api_response.send method_name, *args
    end


    def fc_api
      @_fc_api ||= FoxySync::Api::Messenger.new
    end
  end
end