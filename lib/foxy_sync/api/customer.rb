require 'openssl'

module FoxySync::Api
  #
  # Each method here corresponds to a call in the "Customer" section
  # of the FoxyCart API (customer_get, customer_save, etc.).
  class Customer < Base
    attr_accessor :user

    #
    # Upon initialization requests and retains the
    # response to FoxyCart's customer_get API command.
    # The full response is available via #api_response.
    # [_user_]
    #   An object that responds_to? the following:
    #     * #email
    #     * #password_salt
    #     * #encrypted_password
    #   These are commonly found on +User+ class instances
    #   that work with authentication systems like +Devise+
    def initialize(user)
      self.user = user
      super fc_api.customer_get :customer_email => user.email
    end


    #
    # Sends the customer_save command to the FoxyCart API.
    # Returns a FoxySync::Api::Response
    def save
      salt = user.password_salt
      hash = OpenSSL::HMAC.hexdigest 'sha256', salt, user.encrypted_password + salt
      fc_api.customer_save(
        :customer_email => user.email,
        :customer_password_hash => hash,
        :customer_password_salt => salt
      )
    end
  end
end