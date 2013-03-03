require 'spec_helper'

describe FoxySync::Api::Messenger do
  include_examples 'api setup'


  it 'should be the API URL' do
    url = described_class.const_get(:URL)
    expect(url.host).to eq FoxySync.store_url[FoxySync.store_url.rindex('/')+1..-1]
    expect(url.port).to eq 443
    expect(url.request_uri).to eq '/api'
  end


  it 'should respond_to api methods only' do
    expect(api).to_not respond_to :who
    expect(api).to respond_to :attribute_save
  end


  it 'should raise method missing error if non-api method called' do
    expect(lambda { api.who }).to raise_error NoMethodError
    expect(lambda { api.attribute_save }).to_not raise_error NoMethodError
  end


  context 'API request' do
    it 'should be secure' do
      http.should_receive(:use_ssl=).with true
      api_request
    end


    it 'should be a POST' do
      http.should_receive(:request) do |arg|
        expect(arg).to be_a Net::HTTP::Post
        expect(arg.form_data).to have_key(:api_action)
        expect(arg.form_data).to have_key(:api_token)
      end

      api_request
    end


    it 'should return the body' do
      reply.should_receive(:body)
      api_request
    end
  end

end