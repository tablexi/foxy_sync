require 'digest/sha1'

module FoxySync
  #
  # Holds methods that help with FoxyCart's SSO service
  # (http://wiki.foxycart.com/v/1.0/sso). This module is
  # intended to be mixed into a controller for easy completion
  # of the SSO handshake.
  module Sso
    #
    # Returns the redirect URL that FoxyCart
    # expects to be requested after it hits your
    # application's SSO URL.
    # [_params_]
    #   Something that responds to [] and holds the
    #   'fcsid' and 'timestamp' parameters given by
    #   the FoxyCart SSO request. Usually your controller's
    #   +params+ object.
    # [_user_]
    #   The currently logged in user, if any
    def sso_url(params, user = nil)
      fc_session_id = params['fcsid']
      cid = 0

      if user
        customer = FoxySync::Api::Customer.new user
        cid = customer.customer_id
        cid = customer.save.customer_id if cid.nil?
      end

      timestamp = params['timestamp'].to_i
      later_timestamp = timestamp + 60 * 60
      token = auth_token cid, later_timestamp

      "#{FoxySync.store_url}/checkout?fc_auth_token=#{token}&fcsid=#{fc_session_id}&fc_customer_id=#{cid}&timestamp=#{later_timestamp}"
    end


    private

    def auth_token(customer_id, timestamp)
      Digest::SHA1.hexdigest("#{customer_id}|#{timestamp}|#{FoxySync.api_key}")
    end

  end
end