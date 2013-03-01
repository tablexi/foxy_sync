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


  it 'should return the custom product options in a hash' do
    options = datafeed_custom_product_options(result)
    expect(options).to be_a Hash

    expected_options = {
      'color' => 'red',
      'Quantity Discount' => '$0.50',
      'Price Discount Amount' => '-5%'
    }

    expect(options.size).to eq expected_options.size
    expected_options.each{|k, v| expect(options[k]).to eq v }
  end

end