source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'

# Unicorn as app
gem 'unicorn'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'activeadmin'
gem 'bootstrap', '~> 4.1.2'
gem 'carrierwave'
gem 'config'
gem 'country_select'
gem 'devise'
gem 'exception_notification'
gem 'factory_bot_rails', '~> 4.11', '>= 4.11.1'
gem 'friendly_id'
gem 'globalize', '~> 5.2'
gem 'httparty'
gem 'jquery-rails'
gem 'mini_magick'
gem 'rails-i18n', '~> 5.1', '>= 5.1.2'
gem 'redcarpet'
gem 'simple_form'
gem 'timecop'
gem 'pg'

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
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-rspec', require: false
  gem 'launchy'
  gem 'rack-livereload'
  gem 'rspec-rails', '~> 3.6'
  gem 'pry-rails'
end

group :development do
  gem 'capistrano', '~> 3.11'
  gem 'capistrano-rails', '~> 1.4'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-doc'
  # Spring speeds up development by keeping your application running
  # in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
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
end

# Alain uses PG also for dev and testing to mimic the live server
if `hostname` == 'debzen'
  gem 'pg'
end
