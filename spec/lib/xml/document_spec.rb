require 'spec_helper'

describe FoxySync::Xml::Document do
  let(:document) { described_class.new XmlHelper::API_REPLY }


  it 'should give the raw XML' do
    expect(document.xml).to eq XmlHelper::API_REPLY
  end

  it 'should return all matches if there is more than one' do
    attrs = document.attribute
    attrs.should be_a Array
    attrs.should include 'mightyvite'
    attrs.should include 'wedding'
  end

  it 'should make the XML accessible' do
    document.customer_email.should == 'sam@gmail.com'
    document.customer_password.should match(/[a-z0-9]+/)
    document.customer_id.should match(/\d+/)
  end

  it 'should be a Nokogiri node' do
    document.node.should be_a Nokogiri::XML::Node
  end

  it 'should return nil if the response doc does not have an element matching the method called' do
    document.foofam.should be_nil
  end

  it 'should return nil if the matched element has no text or cdata' do
    document.attributes.should be_nil
  end

end