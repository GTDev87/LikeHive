Given /^"([^"]*)" has a message sent from "([^"]*)" to "([^"]*)" with subject "([^"]*)" and body "([^"]*)"$/ do |user, from_user, to_user, subject, body|
  message = Factory(:message, :from => UserQuery.find_user_by_email(from_user), :to => [UserQuery.find_user_by_email(to_user)], :subject => subject, :body => body)
  found_user = UserQuery.find_user_by_email(user)
  found_user.mailbox.messages << message
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

When /^I visit the message page with subject "([^"]*)"$/ do |message_subject|
  message = Message.first(conditions: { subject: message_subject })
  visit("/messages/#{message._id}")
end