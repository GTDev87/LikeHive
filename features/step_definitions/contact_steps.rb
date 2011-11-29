Then /^User "([^"]*)" should be one of my contacts$/ do |username|
  if page.respond_to? :should
    page.should have_xpath('//user_contacts', :text => username)
  else
    assert page.has_xpath?('//user_contacts', :text => username)
  end
end