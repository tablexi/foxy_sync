module FoxySync::Xml
  #
  # Provides methods to easily query the transaction_detail
  # elements found in a FoxyCart transaction XML datafeed
  class TransactionDetail < Base
    #
    # Returns custom product options in a 'name' => 'value' +Hash+
    def custom_product_options
      options = {}
      options_xml = node.xpath './/transaction_detail_option'

      options_xml.each do |node|
        name = node.at_css('product_option_name').content.strip
        value = node.at_css('product_option_value').content.strip
        options[name] = value
      end

      options
    end
  end
end