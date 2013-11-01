Description
------------
Convert Large XML files into SQL query for a quick and RAM friendly import.


Usage
-------
```ruby
importer = Importer.new('products.xml')
importer.create_sql
```


Results
--------
Here is an example of XML file on input:
```xml
<items>
  <item available="true" id="123">
    <title>Hat</title>
  </item>
  <item available="true" id="456">
    <title>T-shirt</title>
  </item>
</items>
```

The output will be SQL files:

for new records:
```sql
INSERT INTO products ( title, ext_id ) VALUES ( 'Hat', 123 ), 
( 'T-shirt', 456 )
```

for existing records: 
```sql
UPDATE products SET title = 'Hat' WHERE ext_id = 123 LIMIT 1; 
UPDATE products SET title = 'T-shirt' WHERE ext_id = 456 LIMIT 1; 
```
