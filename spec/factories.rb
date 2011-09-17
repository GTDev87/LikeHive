require 'factory_girl'

Factory.define :user do |user|
  user.sequence(:first_name) { |n| "Test User #{n}"}
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.password "please"
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
end

