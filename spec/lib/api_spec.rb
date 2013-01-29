require 'spec_helper'

describe FoxySync::Api do

  let(:api) { described_class.new }

  let(:reply) do
    reply = double 'protocol.request'
    reply.stub(:body).and_return ApiHelper::API_REPLY
    reply
  end

  let(:http) do
    protocol = double 'Net::HTTP'
    protocol.stub :use_ssl=
    protocol.stub :set_debug_output
    protocol.stub(:request).and_return reply
    protocol
  end


  before :each do
    Net::HTTP.stub(:new).and_return http
  end


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


  context 'ApiResponse' do
    let(:api_response) { api_request }

    it 'should be an ApiResponse' do
      api_response.should be_a FoxySync::ApiResponse
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


  def api_request(email = 'sam@gmail.com')
    api.customer_get :email => email
  end

end