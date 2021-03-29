
Given /the following users exist/ do |users_table|
  #byebug
  users_table.hashes.each do |user|
    User.create user
  end
end

Given /the following collectibles exist/ do |users_table|
  #byebug
  users_table.hashes.each do |user|
    Collectible.create user
  end
end

Given /the following assets exist/ do |users_table|
  #byebug
  users_table.hashes.each do |user|
    Asset.create user
  end
end

Given /the following products exist/ do |users_table|
  #byebug
  users_table.hashes.each do |user|
    Product.create user
  end
end

Then /I should see all the users/ do
  # Make sure that all the movies in the app are visible in the table
  User.all.each do |user|
    step %{I should see "#{user.title}"}
  end
end

Then /I should see all of the collectibles of "(.*)"/ do |username|
  # Make sure that all the movies in the app are visible in the table
  #byebug
  user = User.where(username: username)[0]
  collection = Collectible.usersCollection(user)
  collection.each do |c|
    step %{I should see "#{c.name}"}
  end
end

Then /(.*) seed users should exist/ do | n_seeds |
  User.count.should be n_seeds.to_i
end