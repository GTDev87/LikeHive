Given /^"([^"]*)" sent a message to "([^"]*)" with subject "([^"]*)" and body "([^"]*)"$/ do |from_user, to_user, subject, body|
  Factory(:message, :from => UserQuery.find_user_by_email(from_user), :to => [UserQuery.find_user_by_email(to_user)], :subject => subject, :body => body)
end

Then /^I should have message "([^"]*)" in my inbox$/ do |subject|
  if page.respond_to? :should
    page.should have_xpath('//user_inbox', :text => subject)
  else
    assert page.has_xpath?('//user_inbox', :text => subject)
  end
end

Then /^I should have message "([^"]*)" in my outbox$/ do |subject|
  if page.respond_to? :should
    page.should have_xpath('//user_outbox', :text => subject)
  else
    assert page.has_xpath?('//user_outbox', :text => subject)
  end
end