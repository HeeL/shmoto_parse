module XmlParser
  def parse_xml
    Nokogiri::XML::Reader(File.open(@file_name)).each do |node|
      if node.name == 'item' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        yield parse_node(node)
      end
    end
  end

  def parse_node(node)
    Nokogiri::XML.parse(node.outer_xml).children.first
  end
end