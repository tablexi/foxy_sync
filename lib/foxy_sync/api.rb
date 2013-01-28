require 'net/http'
require 'uri'
require 'nokogiri'


module FoxySync
  class Api
    URL = URI.parse "#{FoxySync.store_url}/api"


    def respond_to?(method_name, include_private = false)
      %w(
        store_template_cache
        store_includes_get
        attribute_save
        attribute_list
        attribute_delete
        category_list
        downloadable_list
        customer_get
        customer_save
        customer_list
        customer_address_get
        customer_address_save
        transaction_get
        transaction_list
        transaction_modify
        transaction_datafeed
        subscription_get
        subscription_cancel
        subscription_modify
        subscription_list
        subscription_datafeed
      ).include? method_name.to_s
    end


    private

    def method_missing(method_name, *args, &block)
      return super unless respond_to? method_name
      xml = api_request method_name, args.first || {}
      ApiResponse.new xml
    end


    def api_request(action, params = {})
      params.merge!({
        :api_action => action,
        :api_token => FoxySync.api_key
      })

      attempts = 0

      begin
        http = Net::HTTP.new URL.host, URL.port
        http.use_ssl = true
        #http.set_debug_output $stdout

        request = Net::HTTP::Post.new URL.request_uri
        request.set_form_data params

        response = http.request request
        response.body
      rescue => e
        if attempts < 3
          attempts += 1
          sleep 1
          retry
        end

        raise e
      end
    end
  end


  class ApiResponse
    attr_reader :document

    def initialize(xml)
      @document = Nokogiri::XML(xml) {|config| config.strict.nonet }
    end


    def respond_to?(method_name, include_private = false)
      true # respond to everything; we don't know what will be in the response doc
    end


    private

    def method_missing(method_name, *args, &block)
      node_set = @document.xpath "//#{method_name}"
      return nil if node_set.nil? || node_set.empty?

      contents = node_set.to_a
      contents.map!{|node| node.content }
      contents.delete_if{|content| content.empty? }
      contents.size == 1 ? contents.first : contents
    end
  end
end