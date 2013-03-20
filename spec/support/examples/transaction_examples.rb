shared_examples 'transaction' do
  let :transaction do
    FoxySync::Xml::Transaction.new XmlHelper::TRANSACTION_DECRYPTED
  end
end