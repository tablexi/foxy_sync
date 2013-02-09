require 'openssl'

module FoxySync
  module CartValidation

    #
    # Hashes form input names for cart validation
    # http://wiki.foxycart.com/v/1.0/hmac_validation
    def cart_input_name(name, value, code)
      "#{name.to_s}||#{OpenSSL::HMAC.hexdigest 'sha256', FoxySync.api_key, code.to_s + name.to_s + value.to_s}"
    end

  end
end