require 'spec_helper'

describe FoxySync::Xml::TransactionDetail do
  include_examples 'xml base'

  let :detail do
    transaction = FoxySync::Xml::Transaction.new XmlHelper::TRANSACTION_DECRYPTED
    described_class.new transaction.node.at_xpath('//transaction_detail')
  end


  it 'should return the custom product options in a hash' do
    options = detail.custom_product_options
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