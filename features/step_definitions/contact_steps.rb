Then /^User "([^"]*)" should be one of my contacts$/ do |username|
  if page.respond_to? :should
    page.should have_xpath('//user_contacts', :text => username)
  else
    assert page.has_xpath?('//user_contacts', :text => username)
  end
end

Given /^The following users are contacts:$/ do |usernames|
  user_list = []
  usernames.raw.flatten.map do |username|
    user_list << UserQuery.find_user_by_username(username)
  end
  
  user_list.combination(2) do |username_pair|
    username_pair[0].network.contacts << username_pair[1]
    username_pair[1].network.contacts << username_pair[0]
  end
end