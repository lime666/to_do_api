# Please, run these commands to set up the app:

* `git clone git@github.com:lime666/to_do_api.git`
* `cd to_do_api`
* `bundle`

# Create and migrate database:

* `rails db:create`
* `rails db:migrate`

# Generate swagger docs:

* `rake rswag:specs:swaggerize`

# Run this command to use rails cache in development mode:

* `rails dev:cache`

# Run these commands to run tests:

* `rspec` - to run all tests
* `rspec ./spec/models/user_spec.rb` - f.e., to run specific tests
