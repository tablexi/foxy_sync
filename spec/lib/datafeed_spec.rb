# encoding: utf-8

require 'spec_helper'

describe FoxySync::Datafeed do
  include FoxySync::Datafeed


  let(:result) { datafeed_unwrap({ 'FoxyData' => TransactionHelper::ENCODED_ENCRYPTED }) }


  describe 'datafeed request' do
    it 'should give an ::Api::Response' do
      result.should be_a FoxySync::Api::Response
    end


    it 'should produce a decoded and decrypted XML' do
      doc = Nokogiri::XML(TransactionHelper::DECODED_DECRYPTED) {|config| config.strict.nonet }

      %w(
        processor_response
        customer_first_name
        customer_last_name
        customer_password
        customer_password_salt
        customer_email
        customer_country
      ).each do |elem|
        result.send(elem).should == doc.xpath("//#{elem}").inner_text
      end
    end
  end


  it 'should give the response text expected by FoxyCart' do
    datafeed_response.should == 'foxy'
  end
end