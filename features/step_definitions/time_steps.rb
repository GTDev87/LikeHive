Given /^the current date is "([^"]*)"$/ do |date|
  date_parts = date.split("/")
  month = date_parts[0]
  day = date_parts[1]
  year = date_parts[2]
  Timecop.freeze(year, month, day)
end