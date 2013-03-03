require 'spec_helper'

describe FoxySync::Api::Messenger do
  include_examples 'api setup'


  it 'should be the API URL' do
    url = described_class.const_get(:URL)
    url.host.should == FoxySync.store_url[FoxySync.store_url.rindex('/')+1..-1]
    url.port.should == 443
    url.request_uri.should == '/api'
  end


  it 'should respond_to api methods only' do
    api.should_not respond_to :who
    api.should respond_to :attribute_save
  end


  it 'should raise method missing error if non-api method called' do
    lambda { api.who }.should raise_error NoMethodError
    lambda { api.attribute_save }.should_not raise_error NoMethodError
  end


  context 'API request' do
    it 'should be secure' do
      http.should_receive(:use_ssl=).with true
      api_request
    end


    it 'should be a POST' do
      http.should_receive(:request) do |arg|
        arg.should be_a Net::HTTP::Post
        arg.form_data.should have_key(:api_action)
        arg.form_data.should have_key(:api_token)
      end

      api_request
    end


    it 'should return the body' do
      reply.should_receive(:body)
      api_request
    end
  end

end