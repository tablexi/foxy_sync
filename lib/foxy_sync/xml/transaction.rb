module FoxySync::Xml
  #
  # Provides methods to easily query the transaction
  # elements found in a FoxyCart transaction XML datafeed
  class Transaction < Base

    #
    # Returns an +Array+ of the +Transaction+s in +xml_base+
    # [_transactions_]
    #   A +FoxySync::Xml::Base+ with a transactions element
    def self.all(xml_base)
      transactions = []

      xml_base.node.xpath('//transactions').each do |transaction|
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