FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com"}
    sequence(:username) { |n| "username#{n}"}
    password "please"
    profile {Factory.build(:user_profile)}
    habitation {Factory.build(:user_habitation)}
    personality {Factory.build(:user_personality)}
    mailbox {Factory.build(:user_mailbox)}
    network {Factory.build(:user_network)}
  end

  factory :user_profile do
    name {Factory.build(:user_name)}
    age  {Factory.build(:user_age)}
    gender {Factory.build(:user_gender)}  
  end

  factory :user_name do
    sequence(:first) {|n| "User#{n}"}
    sequence(:last) {|n| "Test#{n}"}
  end

  factory :user_age do
    date_of_birth "1987-06-27"
  end

  factory :user_gender do
    female false 
  end

  factory :user_habitation do
    locations []
  end

  factory :zipcode do
    number "11210"
    geolocation {Factory.build(:geolocation)}
  end

  factory :geolocation do
    coordinates []
  end

  factory :user_personality do
    likes []
  end

  factory :user_mailbox do
    messages []
  end

  factory :user_network do
    contacts []
  end

  factory :contact_message do
    message_data {Factory.build(:message_data)}
  end

  factory :message_data do
    subject "Subject"
    body "Body"
    time "2011-06-16 00:00:00 Z"
  
    from { |from| from.association(:user) }
    to []
  end

  factory :handshake_message do
    message_data {Factory.build(:message_data)}
  end

  factory :like do
    sequence(:name) {|n| "Test Like #{n}"}
    following {Factory.build(:like_following)}
  end
  
  factory :facebook_like do
    facebook_data {Factory.build(:facebook_data)}
    sequence(:name) {|n| "Test Facebook Like #{n}"}
    following {Factory.build(:like_following)}
  end

  factory :facebook_data do
    sequence(:facebook_id) {|n| n }
  end

  factory :like_following do
    users []
  end
end