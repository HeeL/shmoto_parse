module JsonParser
  def parse
    JSON.parse(File.read(@file_name))['items'].each do |item|
      yield parse_item(item)
    end
  end

  private

  def parse_item(item)
    item = {
      id: item['id'],
      available: item['available'].to_s == 'true',
      title: item['true']
    }
  end
end
