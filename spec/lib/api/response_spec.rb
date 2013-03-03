require 'spec_helper'

describe FoxySync::Api::Response do
  include_examples 'api setup'

  it 'should be a NodeResponder' do
    expect(api_response).to be_a FoxySync::Api::NodeResponder
  end

  it 'should give the raw XML' do
    expect(api_response.xml).to eq XmlHelper::API_REPLY
  end

end