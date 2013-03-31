shared_examples 'xml document' do
  include_examples 'xml base'
  let(:base) { described_class.new XmlHelper::API_REPLY }
end