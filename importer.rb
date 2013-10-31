$:.push File.expand_path(File.dirname(__FILE__))

require "xml_parser"
require "nokogiri"

class Importer
  include XmlParser

  def initialize(file_name)
    @file_name = file_name
  end

  def create_sql
    f = start_sql
    parse_xml do |doc|
      next unless doc.attributes['available'].to_s == 'true'
      ext_id = doc.attributes['id']
      title = doc.search('title').text
      f.write "( '#{title}', #{ext_id} ), \n"
      f.flush
    end
  end

  private

  def start_sql
    f = File.open('products.sql', 'w')
    f.write('INSERT INTO products ( title, ext_id ) VALUES ')
    f
  end

end
importer = Importer.new('products.xml')
importer.create_sql