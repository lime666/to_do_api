# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    # if config.use_transactional_fixtures?
    # raise(<<-MSG)
    # Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
    # (or set it to false) to prevent uncommitted transactions being used in
    # JavaScript-dependent specs.

    # During testing, the app-under-test that the browser driver connects to
    # uses a different database connection to the database connection used by
    # the spec. The app's database connection would not be able to access
    # uncommitted transaction data setup over the spec's database connection.
    # MSG
    # end

    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |_example|
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do |_example|
    DatabaseCleaner.start
  end

  config.after(:each) do |_example|
    DatabaseCleaner.clean
  end

  config.before(:all) do
    DatabaseCleaner.start
  end
  config.after(:all) do
    DatabaseCleaner.clean
  end
end
