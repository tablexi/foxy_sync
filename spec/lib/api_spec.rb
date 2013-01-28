require 'spec_helper'

describe FoxySync::Api do

  let(:api) { described_class.new }

  let(:reply) do
    reply = double 'protocol.request'
    reply.stub(:body).and_return API_REPLY
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


  API_REPLY = <<-XML
    <foxydata>
      <store_version>1.0</store_version>
      <result>SUCCESS</result>
      <messages>
        <message>Customer Found</message>
      </messages>
      <customer_id><![CDATA[7946695]]></customer_id>
      <last_modified_date><![CDATA[2013-01-27 12:44:58]]></last_modified_date>
      <customer_first_name><![CDATA[]]></customer_first_name>
      <customer_last_name><![CDATA[]]></customer_last_name>
      <customer_company><![CDATA[]]></customer_company>
      <customer_address1><![CDATA[]]></customer_address1>
      <customer_address2><![CDATA[]]></customer_address2>
      <customer_city><![CDATA[]]></customer_city>
      <customer_state><![CDATA[]]></customer_state>
      <customer_postal_code><![CDATA[]]></customer_postal_code>
      <customer_country><![CDATA[US]]></customer_country>
      <customer_phone><![CDATA[]]></customer_phone>
      <customer_email><![CDATA[sam@gmail.com]]></customer_email>
      <shipping_first_name><![CDATA[]]></shipping_first_name>
      <shipping_last_name><![CDATA[]]></shipping_last_name>
      <shipping_company><![CDATA[]]></shipping_company>
      <shipping_address1><![CDATA[]]></shipping_address1>
      <shipping_address2><![CDATA[]]></shipping_address2>
      <shipping_city><![CDATA[]]></shipping_city>
      <shipping_state><![CDATA[]]></shipping_state>
      <shipping_postal_code><![CDATA[]]></shipping_postal_code>
      <shipping_country><![CDATA[US]]></shipping_country>
      <shipping_phone><![CDATA[]]></shipping_phone>
      <customer_password><![CDATA[35c050a459b9289cadcb5ef1448dccdfdb08030c7f6d1ba7ac60fc3cf19cfc87]]></customer_password>
      <customer_password_salt><![CDATA[PN8HNWhrFQEnymyqrkUS3uRIyhXzVw7Ab9dPZpav5JJxW8MhmyZjWLTkTGJI7KecPhSEwW1vwESiGwrTYk4KWRVGszjpbnsUzetZ]]></customer_password_salt>
      <customer_password_hash_type><![CDATA[sha256_salted_suffix]]></customer_password_hash_type>
      <customer_password_hash_config><![CDATA[070877]]></customer_password_hash_config>
      <cc_type><![CDATA[]]></cc_type>
      <cc_number_masked><![CDATA[]]></cc_number_masked>
      <cc_exp_month><![CDATA[]]></cc_exp_month>
      <cc_exp_year><![CDATA[]]></cc_exp_year>
      <cc_start_date_month><![CDATA[]]></cc_start_date_month>
      <cc_start_date_year><![CDATA[]]></cc_start_date_year>
      <cc_issue_number><![CDATA[]]></cc_issue_number>
      <shipto_addresses></shipto_addresses>
      <attributes>
        <attribute name="customer_type">mightyvite</attribute>
        <attribute name="customer_event">wedding</attribute>
      </attributes>
    </foxydata>
  XML
end