Given /^There is a like named "([^"]*)"$/ do |name|
  LikeCreator.new(:name => name).save!
end

Given /^There are likes named the following:$/ do |likes|
  likes.raw.flatten.map do |like_name|
    Factory(:like, :name => like_name)
  end
end

Given /^The user with email "([^"]*)" likes "([^"]*)"$/ do |email, like_name|
  user = User.find(:first, :conditions => { :email => email.downcase })
  user.add_like(like_name)
end

Given /^I like "([^"]*)"$/ do |like_name|
  @user.add_like(like_name)
end

When /^I look at the "([^"]*)" like page$/ do |like|
  visit("/likes/#{like}")
end

Given /^Nobody likes "([^"]*)"$/ do |like_name|
  assert_equal LikeQuery.find_one_by_name(like_name).following.users.size, 0
end

Given /^I like the following:$/ do |likes|
  likes.raw.flatten.map do |like_name|
    @user.add_like(like_name)
  end
end