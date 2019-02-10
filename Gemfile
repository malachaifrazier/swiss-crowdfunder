source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
gem 'pg'

gem 'puma'

# Use SCSS for stylesheets
gem 'sassc-rails'
gem 'uglifier'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'activeadmin'
gem 'bootstrap', '~> 4.2.1'
gem 'aws-sdk-s3', require: false
gem 'config'
gem 'country_select'
gem 'devise'
gem 'exception_notification'
gem 'factory_bot_rails'
gem 'image_processing', '~> 1.7', '>= 1.7.1'
gem 'friendly_id'
gem 'globalize'
gem 'httparty'
gem 'jquery-rails'
gem 'mini_magick'
gem 'rails-i18n', '~> 5.1'
gem 'redcarpet'
gem 'simple_form'
gem 'timecop'
gem 'bootsnap', require: false

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  # code coverage analysis tool
  gem 'simplecov', require: false
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'spring-commands-rspec'
  gem 'launchy'
  gem 'rack-livereload'
end

group :development do
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'listen', '~> 3.1', '>= 3.1.5'
  gem 'letter_opener'
  gem 'better_errors'
  # Necessary to use Better Errors' advanced features (REPL, local/instance
  # variable inspection, pretty stack frame names).
  gem 'binding_of_caller'
  # A static analysis security vulnerability scanner for Ruby on Rails apps
  gem 'brakeman', require: false
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  # Access an IRB console on exception pages or by using `<%= console # %>`
  # anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end


group :test do
  gem 'database_cleaner'
  # Installs `geckodriver` so that the OS does not have to provide it
  # Required for Capyabara :firefox_headless
  gem 'geckodriver-helper'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
end
