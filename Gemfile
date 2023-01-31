source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

# My used gems
# For managing user roles simply
gem "rolify"
gem 'cancancan'

# For authentication
gem "bcrypt", "~> 3.1.7"
gem 'jwt'

# For pagination
gem 'pagy', '~> 6.0' # omit patch digit

# For .env files
gem 'dotenv-rails', groups: [:development, :test]
# For sending emails
gem 'mailgun-ruby', '~>1.2.6'

# Recomended by github
#Linter
gem 'rubocop', require: false

# For postgresql
gem 'pg'

# Use Active Model Serializers for easier JSON generation 
gem 'active_model_serializers', '~> 0.10.13'



group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # Static analisis tool
  gem 'brakeman'

  #Patch level verification
  gem 'bundler-audit'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # For testing coverage
  gem 'simplecov'
  gem "rspec", "~> 3.12"
  gem "simplecov-lcov", "~> 0.8.0"
end

