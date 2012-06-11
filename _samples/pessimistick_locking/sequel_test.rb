require 'sequel'

DB = Sequel.connect('jdbc:mysql://localhost/toplines?user=root&password=root')

DB.create_table :items do 
  primary_key :id
  String :name
  Float :price
end

items = DB[:items]

items.insert(:name => 'first item', :price => rand * 100)
items.insert(:name => 'second item', :price => rand * 100)

puts "Items count: #{items.count}"

puts "Average price: #{items.avg(:price)}"

