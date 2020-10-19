# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[{"id"=>1, "first_name"=>"Adit", "last_name"=>"Adit", "email"=>"Adit@alcowhiz.com", "password_digest"=>"123456789", "status"=>true,  "category"=>1}, {"id"=>2, "first_name"=>"Adit", "last_name"=>"Agrawal", "email"=>"manager@gmail.com", "password_digest"=>"123456789", "status"=>true,  "category"=>2}, {"id"=>3, "first_name"=>"Arpit", "last_name"=>"Sharma", "email"=>"packaging@gmail.com", "password_digest"=>"123456789", "status"=>true,  "category"=>3}, {"id"=>5, "first_name"=>"Dileshwar", "last_name"=>"Sahu", "email"=>"dileshwar.sahu@alcoeats.com", "password_digest"=>"20091994", "status"=>true, "category"=>1}, {"id"=>6, "first_name"=>"piyush", "last_name"=>"ramwani", "email"=>"piyush.ramwani@alcoeats.com", "password_digest"=>"piyush@123", "status"=>true, "category"=>1}, {"id"=>7, "first_name"=>"menka", "last_name"=>"sahu", "email"=>"menka.sahu@alcoeats.com", "password_digest"=>"menka11@", "status"=>true, "category"=>1}, {"id"=>8, "first_name"=>"anjita", "last_name"=>"baghel", "email"=>"anjita.baghel@alcoeats.com", "password_digest"=>"8463801190", "status"=>true,  "category"=>1}].each do |aa|
  User.create!(aa)
end