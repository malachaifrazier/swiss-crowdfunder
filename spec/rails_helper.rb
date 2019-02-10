# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rails'
require 'capybara/rspec'
require 'selenium/webdriver'
require 'devise'

require 'bundler/setup'
::Bundler.require(:default, :test)

require 'shoulda/matchers'
::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# ---------------------- Begin Capybara configurations ----------------------
Capybara.register_driver :selenium do |app|
  if ENV['SELENIUM_DRIVER_URL'].present?
    args = ["--no-default-browser-check", "--start-maximized"]
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => { "args" => args })

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: ENV.fetch('SELENIUM_DRIVER_URL'),
      desired_capabilities: caps
      # desired_capabilities: :chrome
    )
  else
    options = Selenium::WebDriver::Chrome::Options.new
    # The window size is important for screenshots
    options.add_argument '--window-size=1366,768'
    Selenium::WebDriver::Chrome.driver_path = '/usr/local/bin/chromedriver'
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end
end

Capybara.javascript_driver = :selenium
Capybara.asset_host        = 'http://localhost:3000'
Capybara.server            = :puma

# Avoids problems related to config.action_mailer.default_url_options  when
# trying to follow links in e-mails
Capybara.always_include_port = true

# The default wait time of 2 seconds sometimes generates false
# positives (tests fail only because it took more than 2 secs for the page to
# load).
Capybara.default_max_wait_time = 5

# Allows finding and interacting with hidden elements. Useful when working
# with default browser elements that are hidden by Bootstrap (e.g., file
# input fields).
Capybara.ignore_hidden_elements = false
# ---------------------- End Capybara configurations ----------------------

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Display all JavaScript errors (from the headless browser console) when
  # running JS-enabled feature specs with Selenium and Chrome. Should also
  # work with Firefox.
  class JavaScriptError < StandardError; end
  config.after(:each, type: :feature, js: true) do
    errors = page.driver
                 .browser
                 .manage
                 .logs
                 .get(:browser)
                 .select { |e| e.level == 'SEVERE' && e.message.present? }
                 .map(&:message)
                 .to_a
    raise JavaScriptError, errors.join("\n\n") if errors.present?
  end

  # ------------------- Begin Database Cleaner config --------------------
  config.use_transactional_fixtures = true

  config.before(:suite) do
    # Perform the initial DB cleaning by truncating all the tables
    # DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Using #append_after instead of #after is very important to avoid race
  # conditions between tests.
  config.append_after(:each) do
    DatabaseCleaner.clean
  end
  # ------------------- End Database Cleaner config ---------------------

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
