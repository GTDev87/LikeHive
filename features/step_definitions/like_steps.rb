Given /^There is a like named "([^"]*)"$/ do |name|
  Like.new(:name => name).save!
end

Given /^"([^"]*)" has a like of "([^"]*)"$/ do |user_name, like_name|  
  user = User.all_in(:name => [user_name])[0]
  user.likes <<  Like.create(:name => like_name)
  user.save!
end

When /^I look at the "([^"]*)" like page$/ do |like|
  visit("/likes/#{like}")
end

