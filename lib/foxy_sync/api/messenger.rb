require 'net/http'
require 'uri'

module FoxySync::Api
  #
  # Use this class to send and receive messages to/from
  # the FoxyCart API (http://wiki.foxycart.com/v/1.0/api).
  # To use it create a new instance and then send it a message
  # that corresponds to the FoxyCart API. All messages
  # return an instance of +FoxySync::Api::Response+. For Example:
  #
  # api = FoxySync::Api.new
  # reply = api.customer_get :customer_email => 'foo@bar.com'
  #
  # +Messenger+ instances respond to every API call in FoxyCart v1.0.
  class Messenger
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
      FoxySync::Api::Response.new xml
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
end