# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[{"id"=>1, "from_range"=>100, "to_range"=>299, "discount"=>0.0, "status"=>true}, {"id"=>2, "from_range"=>300, "to_range"=>499, "discount"=>5.0, "status"=>true}, {"id"=>3, "from_range"=>500, "to_range"=>999, "discount"=>10.0, "status"=>true}, {"id"=>4, "from_range"=>1000, "to_range"=>1099, "discount"=>15.0, "status"=>true}].each do |aa|
  Discount.create!(aa)
end

[{"id"=>1, "gst_percentage"=>5, "category"=>1, "status"=>true}].each do |aa|
  Gst.create!(aa)
end

[{"id"=>1, "first_name"=>"Priyanka", "last_name"=>"Khandelwal", "email"=>"caller@mail.com", "password_digest"=>"123456789", "status"=>true, "category"=>1}, {"id"=>2, "first_name"=>"Adit", "last_name"=>"Agrawal", "email"=>"manager@gmail.com", "password_digest"=>"123456789", "status"=>true, "category"=>2}, {"id"=>3, "first_name"=>"Arpit", "last_name"=>"Sharma", "email"=>"packaging@gmail.com", "password_digest"=>"123456789", "status"=>true, "category"=>3}].each do |aa|
  User.create!(aa)
end

