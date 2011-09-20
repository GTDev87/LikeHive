require 'factory_girl'

Factory.define :user do |user|
  user.sequence(:first_name) { |n| "Test User #{n}"}
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.password "please"
  user.female false
  user.date_of_birth "1987-06-27"
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
end

