# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :first_name => 'First User', :last_initial => "E", :date_of_birth => "1987/06/27", :email => 'user@test.com', :password => 'please', :password_confirmation => 'please', :zipcode => "11210"
puts "User is #{user}"
puts 'New user created: ' << user.first_name
