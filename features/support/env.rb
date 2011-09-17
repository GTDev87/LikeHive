# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'
require 'sunspot_test/cucumber'

#for now not sure if this is a good place




SunspotTest.solr_startup_timeout = 60

#Use the following to find your process
#ps aux | grep solr # this will search existing processes for a solr process.
#kill <pid of the solr java process> # this will kill the process with the given PID.

# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how 
# your application behaves in the production environment, where an error page will 
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.orm = 'mongoid'
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :truncation
#   end
#


# Set up solr sunspot testing enviornment
#$original_sunspot_session = Sunspot.session

#Before("~@search") do
#  Sunspot.session = Sunspot::Rails::StubSessionProxy.new($original_sunspot_session)
#end

#Before("@search") do
#  unless $sunspot
#    $sunspot = Sunspot::Rails::Server.new
#    pid = fork do
#      #STDERR.reopen('/dev/null')
#      #STDOUT.reopen('/dev/null')
#      $sunspot.run
#    end
#    # shut down the Solr server
#    at_exit { Process.kill('TERM', pid) }
#    # wait for solr to start
#    sleep 8
#  end
#  Sunspot.session = $original_sunspot_session
#
#  Like.remove_all_from_index!
#end

