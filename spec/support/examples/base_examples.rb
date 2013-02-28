shared_examples 'base' do
  
  it 'should retain the API response' do
    subject.api_response.should be_a FoxySync::Api::Response
  end

  it 'should delegate method_missing to the api_response' do
    subject.api_response.should_receive(:send).with :foofam, :fiddle
    subject.foofam(:fiddle).should be_nil
  end

  it 'should delegate respond_to? to the api_response' do
    subject.api_response.should_receive(:respond_to?).with :foofam, true
    subject.respond_to? :foofam, true
  end
  
end