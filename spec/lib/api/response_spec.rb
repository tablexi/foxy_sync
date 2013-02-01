require 'spec_helper'

describe FoxySync::Api::Response do
  include_examples 'api_setup'


  it 'should be an Api::Response' do
    api_response.should be_a FoxySync::Api::Response
  end


  it 'should make the response XML accessible' do
    api_response.customer_email.should == 'sam@gmail.com'
    api_response.customer_password.should match(/[a-z0-9]+/)
    api_response.customer_id.should match(/\d+/)
  end


  it 'should return all matches if there is more than one' do
    attrs = api_response.attribute
    attrs.should be_a Array
    attrs.size.should == 2
  end


  it 'should be a Nokogiri document' do
    api_response.document.should be_a Nokogiri::XML::Document
  end


  it 'should return nil if the response doc does not have an element matching the method called' do
    api_response.foofam.should be_nil
  end

end