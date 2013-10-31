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

The output will be an SQL file:
```sql
INSERT INTO products ( title, ext_id ) VALUES ( 'Hat', 123 ), 
( 'T-shirt', 456 )
```