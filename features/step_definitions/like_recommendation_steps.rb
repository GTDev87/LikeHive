Then /^I should not be recommended:$/ do |likes|
  likes.raw.flatten.map do |like_name|   
    if page.respond_to? :should
      page.should have_no_xpath('//interests', :text => like_name)
    else
      assert page.has_no_xpath?('//interests', :text => like_name)
    end
  end
end