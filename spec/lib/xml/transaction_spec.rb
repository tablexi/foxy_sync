require 'spec_helper'

describe FoxySync::Xml::Transaction do
  
  let :document do
    FoxySync::Xml::Document.new XmlHelper::TRANSACTION_DECRYPTED
  end

  let(:transactions) { described_class.all document }


  describe 'getting all transactions' do
    it 'should have one transaction' do
      expect(transactions.size).to eq 1
      expect(transactions.first).to be_a described_class
    end

    it 'should have the right customer ip' do
      expect(transactions.first.customer_ip).to eq document.customer_ip
    end

    it 'should have the right order total' do
      expect(transactions.first.order_total).to eq document.order_total
    end

    it 'should have the right receipt url' do
      expect(transactions.first.receipt_url).to eq document.receipt_url
    end
  end


  it 'should return all transaction details' do
    transaction = transactions.first
    details = transaction.transaction_details
    expect(details.size).to eq 1
    expect(details.first).to be_a FoxySync::Xml::TransactionDetail
  end
  
end