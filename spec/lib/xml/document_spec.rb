require 'spec_helper'

describe FoxySync::Xml::Document do
  include_examples 'xml document'

  it 'should give the raw XML' do
    expect(base.xml).to eq XmlHelper::API_REPLY
  end

  it 'should make the XML accessible' do
    expect(base.customer_email).to eq 'sam@gmail.com'
    expect(base.customer_password).to match(/[a-z0-9]+/)
    expect(base.customer_id).to match(/\d+/)
  end
end