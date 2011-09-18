Given /^no user exists with an email of "(.*)"$/ do |email|
  UserQuery.find_user_by_email(email).should be_nil
end

Given /^I am a user with an email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  @user = Factory(:user, :email => email, :password => password)
end

Given /^There is a user with an email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Factory(:user, :email => email, :password => password)
end

Given /^The following user:$/ do |table|
  #Feed the following attributes like the following:
  # | First name  | email         | Password  |
  # | Greg        | Greg@greg.com | password  |
  table.hashes.each do |attributes|
    Factory.create(:user, attributes)
  end
end

Given /^I am a user with the following:$/ do |table|
  #Feed the following attributes like the following:
  # | First name  | email         | Password  |
  # | Greg        | Greg@greg.com | password  |
  table.hashes.each do |attributes|
    @user = Factory.create(:user, attributes)
  end
end


Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Login"}
  And %{I should not see "Logout"}
end

Given /^I have a like "([^"]*)"$/ do |like_name|
  like = LikeCreator.create(name: like_name)
  @user.get_likes.add_like(like_name)
  @user.save!()
end
