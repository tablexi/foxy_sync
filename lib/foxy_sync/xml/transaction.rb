module FoxySync::Xml
  #
  # Provides methods to easily query the transaction
  # elements found in a FoxyCart transaction XML datafeed
  class Transaction < Base

    #
    # Returns an +Array+ of +Transaction+s from +transaction_doc+
    # [_transaction_doc_]
    #   A +FoxySync::Xml::Document+ that holds a transaction XML datafeed
    def self.all(transaction_doc)
      transactions = []

      transaction_doc.node.xpath('//transactions').each do |transaction|
        transactions << new(transaction)
      end

      transactions
    end


    #
    # Returns all transaction_detail elements wrapped
    # in a +FoxySync::Xml::TransactionDetail+
    def transaction_details
      TransactionDetail.all self
    end
  end
end