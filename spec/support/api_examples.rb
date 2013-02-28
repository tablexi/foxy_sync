require 'net/http'

shared_examples 'api_setup' do

  let(:api) { FoxySync::Api::Messenger.new }


  let(:api_response) { api_request }


  let :reply do
    reply = double 'protocol.request'
    reply.stub(:body).and_return API_REPLY
    reply
  end


  let :http do
    protocol = double 'Net::HTTP'
    protocol.stub :use_ssl=
    protocol.stub :set_debug_output
    protocol.stub(:request).and_return reply
    protocol
  end


  before :each do
    Net::HTTP.stub(:new).and_return http
  end


  def api_request(email = 'sam@gmail.com')
   api.customer_get :customer_email => email
  end

  path = File.expand_path 'response.xml', File.dirname(__FILE__)
  API_REPLY = File.open(path, 'r').readlines(nil)[0]
end