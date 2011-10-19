Then /^I should not be recommended:$/ do |likes|
  likes.raw.flatten.map do |like_name|   
    if page.respond_to? :should
      page.should have_no_xpath('//like_recommendations/a', :text => like_name)
    else
      assert page.has_no_xpath?('//like_recommendations/a', :text => like_name)
    end
  end
end

Then /^I should be recommended:$/ do |likes|
  likes.raw.flatten.map do |like_name|
    if page.respond_to? :should
      page.should have_xpath('//like_recommendations/a', :text => like_name)
    else
      assert page.has_xpath?('//like_recommendations/a', :text => like_name)
    end
  end
end