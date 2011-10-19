Then /^I should see a recommended user with:$/ do |users|
  users.raw.flatten.map do |user_name|
    if page.respond_to? :should
      page.should have_xpath('//user_recommendations', :text => user_name)
    else
      assert page.has_xpath?('//user_recommendations', :text => user_name)
    end
  end
end