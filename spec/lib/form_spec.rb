require 'spec_helper'

describe FoxySync::Form do

  let(:form) do
    mock = double('form')
    mock.class.send :include, FoxySync::Form
    mock
  end


  it 'should return a value usable as an HMAC valid name input' do
    name, value, code = 'thingee', '$100.00', 'ABC123'
    form.input_name(name, value, code).should match(/#{name}\|\|[a-z0-9]+/)
  end

end