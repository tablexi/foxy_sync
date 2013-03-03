module FoxySync::Api

  class NodeResponder

    attr_reader :node


    def initialize(node)
      @node = node
    end


    def respond_to?(method_name, include_private = false)
      true # respond to everything; we don't know what will be in the response doc
    end


    private

    def method_missing(method_name, *args, &block)
      node_set = node.xpath "//#{method_name}"
      return nil if node_set.nil? || node_set.empty?

      contents = []

      node_set.children.each do |child|
        next if child.element?
        content = child.content.strip
        contents << content unless content.empty?
      end

      contents.empty? ? nil : contents.size == 1 ? contents.first : contents
    end

  end

end