Given /^There is a like named "([^"]*)"$/ do |name|
  LikeCreator.new(:name => name).save!
end

Given /^The user with email "([^"]*)" likes "([^"]*)"$/ do |email, like_name|
  user = User.find(:first, :conditions => { :email => email.downcase })
  like = LikeCreator.create(:name => like_name.downcase)
  like.get_followers << user
end

When /^I look at the "([^"]*)" like page$/ do |like|
  visit("/likes/#{like}")
end

Given /^Nobody likes "([^"]*)"$/ do |like_name|
  assert_equal LikeQuery.find_one_by_name(like_name).get_followers.num_users, 0
end

