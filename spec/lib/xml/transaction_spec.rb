require 'spec_helper'

describe FoxySync::Xml::Transaction do
  include_examples 'transaction'


  it 'should return the custom product options in a hash' do
    fields = transaction.custom_fields
    expect(fields).to be_a Hash

    expected_options = {
      'Occassion' => 'wedding',
      'Held_On' => '10/1/11'
    }

    expect(fields.size).to eq expected_options.size
    expected_options.each{|k, v| expect(fields[k]).to eq v }
  end


  describe 'getting all details' do
    let(:details) { transaction.details }
    let(:detail) { details.first }

    it 'should have one detail' do
      expect(details.size).to eq 1
      expect(details.first).to be_a FoxySync::Xml::TransactionDetail
    end

    it 'should have the right product_code' do
      expect(detail.product_code).to eq transaction.product_code
    end

    it 'should have the right product name' do
      expect(detail.product_name).to eq transaction.product_name
    end

    it 'should have the right product quantity' do
      expect(detail.product_quantity).to eq transaction.product_quantity
    end
  end
end