Then /^I should see a recommended user with:$/ do |strings|
  strings.raw.flatten.map do |string|
    if page.respond_to? :should
      page.should have_xpath('//user_recommendations', :text => string)
    else
      assert page.has_xpath?('//user_recommendations', :text => string)
    end
  end
end

Then /^I should not see a recommended user with:$/ do |strings|
  strings.raw.flatten.map do |string|
    if page.respond_to? :should
      page.should have_no_xpath('//user_recommendations', :text => string)
    else
      assert page.has_no_xpath?('//user_recommendations', :text => string)
    end
  end
end