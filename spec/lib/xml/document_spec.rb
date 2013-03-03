require 'spec_helper'

describe FoxySync::Xml::Document do
  let(:document) { described_class.new XmlHelper::API_REPLY }


  it 'should give the raw XML' do
    expect(document.xml).to eq XmlHelper::API_REPLY
  end

  it 'should return all matches if there is more than one' do
    attrs = document.attribute
    expect(attrs).to be_a Array
    expect(attrs).to include 'mightyvite'
    expect(attrs).to include 'wedding'
  end

  it 'should make the XML accessible' do
    expect(document.customer_email).to eq 'sam@gmail.com'
    expect(document.customer_password).to match(/[a-z0-9]+/)
    expect(document.customer_id).to match(/\d+/)
  end

  it 'should be a Nokogiri node' do
    expect(document.node).to be_a Nokogiri::XML::Node
  end

  it 'should return nil if the response doc does not have an element matching the method called' do
    expect(document.foofam).to be_nil
  end

  it 'should return nil if the matched element has no text or cdata' do
    expect(document.attributes).to be_nil
  end

end