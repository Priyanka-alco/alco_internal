# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


[{"id"=>1, "product_name"=>"Turmeric", "description"=>"Good For Health", "image"=>"", "over_all_rating"=>5.0, "discount_available"=>true, "total_quantity"=>6, "available"=>true, "vendor_detail_id"=>nil}, {"id"=>2, "product_name"=>"Chilli Powder", "description"=>"Organic", "image"=>nil, "over_all_rating"=>5.0, "discount_available"=>true, "total_quantity"=>8, "available"=>true, "vendor_detail_id"=>nil}].each do |aa|
  Product.create!(aa)
end

