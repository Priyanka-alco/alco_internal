# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[{"id"=>1, "from_range"=>100, "to_range"=>300, "discount"=>0.0, "status"=>true}, {"id"=>2, "from_range"=>301, "to_range"=>500, "discount"=>5.0, "status"=>true, "created_at"=>Wed, 20 Jan 2010 00:00:00 UTC +00:00, "updated_at"=>Wed, 20 Jan 2010 00:00:00 UTC +00:00}, {"id"=>3, "from_range"=>501, "to_range"=>1000, "discount"=>10.0, "status"=>true}, {"id"=>4, "from_range"=>1001, "to_range"=>2000, "discount"=>15.0, "status"=>true}].each do |aa|
  Discount.create!(aa)
end