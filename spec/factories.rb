Factory.define :user do |user|
  user.name {Factory.build(:user_name)}
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.password "please"
  user.age  {Factory.build(:user_age)}
  user.gender {Factory.build(:user_gender)}
  user.residence {Factory.build(:user_residence)}
  user.personality {Factory.build(:user_personality)}
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

Factory.define :user_residence do |residence|
  residence.locations []
end

Factory.define :zipcode do |zipcode|
  zipcode.number "11210"
end

Factory.define :user_personality do |personality|
  personality.likes []
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
  like.following {Factory.build(:like_following)}
end

Factory.define :like_following do |like_following|
  like_following.users []
end