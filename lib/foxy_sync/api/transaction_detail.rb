module FoxySync::Api
  #
  # Provides methods to easily query the transaction_detail
  # elements found in FoxyCart's datafeed XML
  class TransactionDetail < NodeResponder

    #
    # Returns an +Array+ of +TransactionDetail+s from an +Api::Response+
    # [_api_response_]
    #   A +FoxySync::Api::Response+
    def self.all(api_response)
      transactions = []

      api_response.node.xpath('//transaction_details').each do |transaction|
        transactions << new(transaction)
      end

      transactions
    end


    #
    # Retrieves custom product options from +api_response+
    # and returns them in a +Hash+ of 'name' => 'value'
    # [_api_response_]
    #   The return of #datafeed_unwrap
    def custom_product_options
      options = {}
      options_xml = node.xpath '//transaction_detail_option'

      options_xml.each do |node|
        name = node.at_css('product_option_name').content.strip
        value = node.at_css('product_option_value').content.strip
        options[name] = value
      end

      options
    end

  end

end