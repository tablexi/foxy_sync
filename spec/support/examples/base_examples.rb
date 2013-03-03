shared_examples 'base' do
  
  it 'should retain the API response' do
    expect(subject.api_response).to be_a FoxySync::Xml::Document
  end

  it 'should delegate method_missing to the api_response' do
    expect(subject.api_response).to_receive(:send).with :foofam, :fiddle
    expect(subject.foofam(:fiddle)).to be_nil
  end

  it 'should delegate respond_to? to the api_response' do
    subject.api_response.should_receive(:respond_to?).with :foofam, true
    subject.respond_to? :foofam, true
  end
  
end