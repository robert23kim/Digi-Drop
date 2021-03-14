
Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the users/ do
  # Make sure that all the movies in the app are visible in the table
  User.all.each do |user|
    step %{I should see "#{user.title}"}
  end
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |mov, dir|
  Movie.find_by_title(mov).director.should == dir
end

Then /(.*) seed users should exist/ do | n_seeds |
  User.count.should be n_seeds.to_i
end