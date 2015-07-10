# My Recipes.

Rails website to browse and add different recipes

Feel free to play around with the application to browse and add new recipes or reviews.

(https://my-recipes-2015.herokuapp.com)

## Development Use:

Clone repo:
   
  ```bash
  $ git clone git@github.com:zapidan/my-recipes.git
  ```

Install gems:

  ```ruby
  bundle install --without production
  ```

Install figaro (needed to create ENV variables to create the admin user from the seeds.rb):

  ```bash
  $ figaro install
  ```

Create ENV variables in application.yml

  ```yml
  admin-name: "Admin name"
  admin-email: "admin@example.com"
  admin-password: "password"
  ```

Run db migrations and seeding of admin: 

  ```ruby
  rake db:setup
  ```

Start server and enjoy!

  ```ruby
  rails server
  ```
