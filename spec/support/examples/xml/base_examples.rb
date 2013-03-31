require 'nokogiri'

shared_examples 'xml base' do

  let :base do
    xml = Nokogiri::XML(XmlHelper::API_REPLY) {|config| config.strict.nonet }
    described_class.new xml
  end


  it 'should be a Nokogiri node' do
    expect(base.node).to be_a Nokogiri::XML::Node
  end

  it 'should return nil if the response doc does not have an element matching the method called' do
    expect(base.foofam).to be_nil
  end

  it 'should return nil if the matched element has no text or cdata' do
    expect(base.attributes).to be_nil
  end

  it 'should return all matches if there is more than one' do
    attrs = base.attribute
    expect(attrs).to be_a Array
    expect(attrs).to include 'mightyvite'
    expect(attrs).to include 'wedding'
  end
end