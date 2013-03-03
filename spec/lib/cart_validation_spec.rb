require 'spec_helper'

describe FoxySync::CartValidation do
  include FoxySync::CartValidation

  it 'should return a value usable as an HMAC valid name input' do
    name, value, code = 'thingee', '$100.00', 'ABC123'
    expect(cart_input_name(name, value, code)).to match(/#{name}\|\|[a-z0-9]+/)
  end

end