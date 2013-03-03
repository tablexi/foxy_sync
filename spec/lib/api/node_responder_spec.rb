require 'spec_helper'

describe FoxySync::Api::NodeResponder do

  let(:responder) do 
    document = Nokogiri::XML(XmlHelper::API_REPLY) {|config| config.strict.nonet }
    described_class.new document
  end
    
  
  it 'should return all matches if there is more than one' do
    attrs = responder.attribute
    attrs.should be_a Array
    attrs.should include 'mightyvite'
    attrs.should include 'wedding'
  end
  
  it 'should make the XML accessible' do
    responder.customer_email.should == 'sam@gmail.com'
    responder.customer_password.should match(/[a-z0-9]+/)
    responder.customer_id.should match(/\d+/)
  end

  it 'should be a Nokogiri node' do
    responder.node.should be_a Nokogiri::XML::Node
  end

  it 'should return nil if the response doc does not have an element matching the method called' do
    responder.foofam.should be_nil
  end

  it 'should return nil if the matched element has no text or cdata' do
    responder.attributes.should be_nil
  end

end