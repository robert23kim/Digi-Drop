When /I fill in "Username" with a nonexistent user/ do
  @new_username = (0...8).map { (65 + rand(26)).chr }.join
  fill_in("Username", :with => @new_username)
end  

When /^(?:|I )follow first "([^"]*)"$/ do |link|
  click_link(link, match: :first)
end

Given /the following users registered/ do |users_table|
  #byebug
  users_table.hashes.each do |user|
    @orignal_password = user["password_digest"]
    user["password_digest"] = password_digest(@orignal_password)
    User.create user
  end
end

def password_digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end


Given /user is logged out/ do
  reset_session!
end

Given /I am logged_in as "john123"/ do
  visit("/login")
  fill_in("username", :with => "john123")
  fill_in("password", :with => "123456")
  click_button("Login")
end

Given /^I am logged_in as "([^"]*)" with password "([^"]*)"$/ do |arg1, arg2|
  visit("/login")
  fill_in("username", :with => arg1)
  fill_in("password", :with => arg2)
  click_button("Login")
end

When /^I sign up as "([^"]*)" with password "([^"]*)"$/ do |arg1, arg2|
  step %{I follow "Not logged in"}
  step %{I follow "Sign up"}
  step %{I should be on the signup page}
  step %{I fill in "Username" with "#{arg1}"}
  step %{I fill in "Password" with "#{arg2}"}
  step %{I press "Create Account"}
  step %{I should be on the homepage}
end