# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[{"id"=>1, "product_id"=>1, "sku"=>200, "category"=>1, "selling_rice"=>500.0, "cost_price"=>350.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>2, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sun, 18 Oct 2020}, {"id"=>2, "product_id"=>1, "sku"=>600, "category"=>2, "selling_rice"=>500.0, "cost_price"=>350.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>2, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sat, 17 Oct 2020}, {"id"=>3, "product_id"=>1, "sku"=>600, "category"=>3, "selling_rice"=>500.0, "cost_price"=>350.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>1, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sat, 17 Oct 2020}, {"id"=>4, "product_id"=>2, "sku"=>300, "category"=>1, "selling_rice"=>300.0, "cost_price"=>50.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>3, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sun, 18 Oct 2020}, {"id"=>5, "product_id"=>2, "sku"=>600, "category"=>2, "selling_rice"=>600.0, "cost_price"=>150.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>4, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sat, 17 Oct 2020}, {"id"=>6, "product_id"=>2, "sku"=>900, "category"=>3, "selling_rice"=>900.0, "cost_price"=>200.0, "gst"=>15.0, "discount_id"=>nil, "discount_amount"=>nil, "discount_percentage"=>nil, "quantity"=>5, "exchange_available"=>true, "replace"=>true, "status"=>true, "delivery_date"=>Sat, 17 Oct 2020}].each do |aa|
  ProductDetail.create!(aa)
end

[{"id"=>1, "product_name"=>"Turmeric", "description"=>"Good For Health", "image"=>"", "over_all_rating"=>5.0, "discount_available"=>true, "total_quantity"=>6, "available"=>true, "vendor_detail_id"=>nil}, {"id"=>2, "product_name"=>"Chilli Powder", "description"=>"Organic", "image"=>nil, "over_all_rating"=>5.0, "discount_available"=>true, "total_quantity"=>8, "available"=>true, "vendor_detail_id"=>nil}].each do |aa|
  Product.create!(aa)
end