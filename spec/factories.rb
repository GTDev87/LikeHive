require 'factory_girl'

Factory.define :user do |user|
  user.name 'Test User'
  user.email 'user@test.com'
  user.password 'please'
end

Factory.define :like do |like|
  like.name 'Test Like'
end

