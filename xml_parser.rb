module XmlParser
  def parse
    Nokogiri::XML::Reader(File.open(@file_name)).each do |node|
      if node.name == 'item' && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
        yield parse_node(node)
      end
    end
  end

  private

  def parse_node(node)
    doc = Nokogiri::XML.parse(node.outer_xml).children.first
    item = {
      id: doc.attributes['id'],
      available: doc.attributes['available'].to_s == 'true',
      title: doc.search('title').text
    }
  end
end