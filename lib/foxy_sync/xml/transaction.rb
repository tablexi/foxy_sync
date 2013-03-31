module FoxySync::Xml
  #
  # Encapsulates FoxyCart's transaction XML datafeed
  class Transaction < Document
    #
    # Returns an +Array+ of the +TransactionDetail+s in this +Transaction+
    def details
      unless @details
        @details = []

        node.xpath('.//transaction_detail').each do |detail|
          @details << TransactionDetail.new(detail)
        end
      end

      @details
    end


    #
    # Returns custom fields in a 'name' => 'value' +Hash+
    def custom_fields
      fields = {}
      fields_xml = node.xpath './/custom_field'

      fields_xml.each do |node|
        name = node.at_css('custom_field_name').content.strip
        value = node.at_css('custom_field_value').content.strip
        fields[name] = value
      end

      fields
    end
  end
end