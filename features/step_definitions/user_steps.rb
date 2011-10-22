Given /^no user exists with an email of "(.*)"$/ do |email|
  UserQuery.find_user_by_email(email).should be_nil
end

Given /^I am a user with an email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  @user = Factory(:user, :email => email, :password => password)
  @user.habitation.locations = [Factory.build(:zipcode)]
end

Given /^There is a user with an email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  user = Factory(:user, :email => email, :password => password)
  user.habitation.locations = [Factory.build(:zipcode)]
end

Given /^I have first name "([^"]*)" and last initial "([^"]*)"$/ do |first_name, last_initial|
  @user.profile.name.first = first_name
  @user.profile.name.last_initial = last_initial
  @user.save!
end

Given /^the email "([^"]*)" has the user name "([^"]*)"$/ do |email, name|
  user = UserQuery.find_user_by_email(email)
  user.profile.name = Factory.build(:user_name, :first => name)
  user.profile.name.save
end

Given /^my gender is "([^"]*)"$/ do |gender|
  if gender.downcase == "male"
    @user.pofile.gender.female = false
  end
  if gender.downcase == "female"
    @user.profile.gender.female = true
  end
  @user.save!
end

Given /^my date of birth is "([^"]*)"$/ do |date_of_birth|
  @user.profile.age.date_of_birth = date_of_birth
  @user.save!
end

Given /^my zipcode is "([^"]*)"$/ do |zipcode|
  zip = Factory.build(:zipcode, :number => zipcode)
  @user.habitation.locations = [zip]
  @user.save!
end

Then /^I should be already signed in$/ do
  And %{I should see "Logged in as"}
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

When /^I sign out$/ do
  visit('/logout')
end

When /^I signup$/ do
  visit('/signup')
end

When /^I login$/ do
  visit('/login')
end

When /^I navigate to the user "([^"]*)" page$/ do |user_page|
  visit("/users/#{user_page}")
end

Given /^I am logout$/ do
  Given %{I sign out}
end

Given /^I am not logged in$/ do
  Given %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I login}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Log in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Log in"}
  And %{I should not see "Logout"}
end

Given /^I have a like "([^"]*)"$/ do |like_name|
  like = LikeCreator.create(name: like_name)
  @user.like_name = like_name
  @user.save!()
end

Given /^There are the following users:$/ do |emails|
  emails.raw.flatten.map do |user_email|
    Factory(:user, :email => user_email)
  end
end
