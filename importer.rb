$:.push File.expand_path(File.dirname(__FILE__))

require "nokogiri"
require "xml_parser"
require "json"
require "json_parser"

class Importer

  def initialize(file_name)
    @file_name = file_name
    case File.extname(file_name)
    when '.json'
      self.class.send(:include, JsonParser)
    when '.xml'
      self.class.send(:include, XmlParser)
    else
      raise 'Unknown format'
    end
  end

  def create_sql
    f_ins, f_upd = start_sql
    parse do |item|
      next unless item[:available]
      if item_exists?(item[:id])
        f_upd.write("UPDATE products SET title = '#{item[:title]}', available = true WHERE ext_id = #{item[:id]} LIMIT 1; \n");
        f_upd.flush
      else
        f_ins.write "( '#{item[:title]}', #{item[:id]} ), \n"
        f_ins.flush
      end
    end
  end

  private

  def start_sql
    f_ins = File.open('insert_products.sql', 'w')
    f_upd = File.open('update_products.sql', 'w')
    f_ins.write('INSERT INTO products ( title, ext_id ) VALUES ')
    return f_ins, f_upd
  end

  def item_exists?(id)
    # here you can implement a check whether an item is already in db
    # example: Product.where(ext_id: id).first
    true
  end
end
importer = Importer.new('products.xml')
importer.create_sql