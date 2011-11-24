Factory.define :user do |user|
  user.sequence(:email) { |n| "user#{n}@test.com"}
  user.sequence(:username) { |n| "username#{n}"}
  user.password "please"
  user.profile {Factory.build(:user_profile)}
  user.habitation {Factory.build(:user_habitation)}
  user.personality {Factory.build(:user_personality)}
  user.mailbox {Factory.build(:user_mailbox)}
end

Factory.define :user_profile do |profile|
  profile.name {Factory.build(:user_name)}
  profile.age  {Factory.build(:user_age)}
  profile.gender {Factory.build(:user_gender)}  
end

Factory.define :user_name do |name|
  name.sequence(:first) {|n| "User#{n}"}
  name.last_initial "T"
end

Factory.define :user_age do |age|
  age.date_of_birth "1987-06-27"
end

Factory.define :user_gender do |gender|
  gender.female false 
end

Factory.define :user_habitation do |habitation|
  habitation.locations []
end

Factory.define :zipcode do |zipcode|
  zipcode.number "11210"
  zipcode.geolocation {Factory.build(:geolocation)}
end

Factory.define :geolocation do |geolocation|
  geolocation.coordinates []
end

Factory.define :user_personality do |personality|
  personality.likes []
end

Factory.define :user_mailbox do |mailbox|
  mailbox.messages []
end

Factory.define :connection_message do |connection_message|
  connection_message.message_data {Factory.build(:message_data)}
end

Factory.define :message_data do |message_data|
  message_data.subject "Subject"
  message_data.body "Body"
  message_data.time "2011-06-16 00:00:00 Z"
  
  message_data.from { |from| from.association(:user) }
  message_data.to []
end

Factory.define :handshake_message do |handshake_message|
  handshake_message.message_data {Factory.build(:message_data)}
end

Factory.define :like do |like|
  like.sequence(:name) {|n| "Test Like #{n}"}
  like.following {Factory.build(:like_following)}
end

Factory.define :like_following do |like_following|
  like_following.users []
end