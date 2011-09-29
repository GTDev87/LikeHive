Factory.define :user do |user|
  user.name {Factory.build(:user_name)}
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.password "please"
  user.age  {Factory.build(:user_age)}
  user.gender {Factory.build(:user_gender)}
  user.zipcode "11210"
end

Factory.define :user_name do |name|
  name.sequence(:first) {|n| "UserName#{n}"}
  name.last_initial "T"
end

Factory.define :user_age do |age|
  age.date_of_birth "1987-06-27"
end

Factory.define :user_gender do |gender|
  gender.female false 
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
end