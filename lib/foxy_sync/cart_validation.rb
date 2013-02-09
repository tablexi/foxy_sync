require 'openssl'

module FoxySync
  #
  # Holds methods to help with FoxyCart's HMAC link and form (cart) validation
  # (http://wiki.foxycart.com/v/1.0/hmac_validation)
  module CartValidation

    #
    # Creates the value expected on name elements of form inputs
    # [_name_]
    #  The plain text value of the name element
    # [_value_]
    #  The value of the input with name +name+
    # [_code_]
    #  The code of the product that the input relates to
    def cart_input_name(name, value, code)
      "#{name.to_s}||#{OpenSSL::HMAC.hexdigest 'sha256', FoxySync.api_key, code.to_s + name.to_s + value.to_s}"
    end

  end
end