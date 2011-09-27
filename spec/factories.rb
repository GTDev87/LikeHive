Factory.define :user do |user|
  user.name {Factory.build(:user_name)}
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.password "please"
  user.female false
  user.date_of_birth "1987-06-27"
  user.zipcode "11210"
end

Factory.define :user_name do |name|
  name.sequence(:first) {|n| "UserName#{n}"}
  name.last_initial "T"
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
end