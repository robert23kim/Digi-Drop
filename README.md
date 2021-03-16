Team Members
Robert Kim rk3145
Jeremy Lu jl5921
Phillip Amankwaa poa2104
Kuo Bao kb3219

Heroku deployment link
https://pacific-ravine-08432.herokuapp.com/

Github source code
https://github.com/robert23kim/project-digi-id

User stories
User stories are written in cucumber and can be found in the features folder. To run them use “bundle exec rake cucumber” in the project-digi-id directory.

Unit tests
Unit tests are written in rspec and can be found in the spec folder. To run them use “bundle exec rake spec” or “bundle exec rspec” in the project-digi-id directory.

Note: Please note that our application changed from the proposal. We decided to pivot to create an application that fits an existent market better. There are a lot of people interested in NFT and collectible items. We decided to create an application that allows users to open cases and receive collectible items of different rarity that can be showcased on their profiles and sold on our marketplace to other users of the platform.

The basic features included in this iteration

Basic user authentication and user-specific features
Log in
To test log in, please use user: john123 password: 123456

Log out
To test log out, follow the login steps and hit the log out button

Sign up
To test sign up, enter your unique username, such as rk3145, and any password, such as 12345

Homepage
- Displays the users, number of collectibles they have, and the total value of all their collectibles
- Displays the users in the descending order of the total value of all their collectibles

Open case
Users can open cases to receive random collectibles. For now all the collectibles have the same chance of being dropped, but in the future the likelihood of a certain collectible being dropped will depend on the rarity of a particular collectible. For now the value of each collectible is permanently set in the db, but in the future, the value will be determined by the marketplace where users can sell and buy each others’ collectibles. 
To test the open case feature, log in, click on Cases button from the home page and click Open Case button. You will see your collectible item on the screen and you will now be the owner of this rare collectible. Congratulations.

Manage collectibles page
Users can view all their collectibles on the Manage Collectibles page.
To test this, log in and click on the Manage Collectibles button from the home page. 


Note:
If running locally instead of heroku
$ bundle install --without production
$ bundle exec rake db:migrate
$ bundle exec rake db:test:prepare
$ bundle exec rake db:seed
$ rails server -b 0.0.0.0
