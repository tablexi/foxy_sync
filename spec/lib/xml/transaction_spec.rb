require 'spec_helper'

describe FoxySync::Xml::Transaction do
  include_examples 'xml document'

  let :transaction do
    FoxySync::Xml::Transaction.new XmlHelper::TRANSACTION_DECRYPTED
  end


  it 'should return the custom product options in a hash' do
    fields = transaction.custom_fields
    expect(fields).to be_a Hash

    expected_options = {
      'Occasion' => 'wedding',
      'Held_On' => '10/1/11'
    }

    expect(fields.size).to eq expected_options.size
    expected_options.each{|k, v| expect(fields[k]).to eq v }
  end


  describe 'getting all details' do
    let(:details) { transaction.details }

    it 'should have four details' do
      expect(details.size).to eq 4
      expect(details.all?{|detail| detail.is_a? FoxySync::Xml::TransactionDetail}).to be_true
    end

    it 'should have the right product_code' do
      expect(details.collect(&:product_code)).to eq transaction.product_code
    end

    it 'should have the right product name' do
      expect(details.collect(&:product_name)).to eq transaction.product_name
    end

    it 'should have the right product quantity' do
      expect(details.collect(&:product_quantity)).to eq transaction.product_quantity
    end
  end
end