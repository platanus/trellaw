source 'https://rubygems.org'

gem 'rails', '~> 5.1.1'

gem 'active_model_serializers', '~> 0.9.3'
gem 'active_skin'
gem 'activeadmin', '~> 1.0.0.pre5'
gem 'activeadmin_addons'
gem 'aws-sdk', '~> 2.5'
gem 'aws-sdk-rails'
gem 'clockwork'
gem 'coffee-rails', '~> 4.2'
gem 'delayed_job_active_record'
gem 'devise'
gem 'devise-i18n'
gem 'jbuilder', '~> 2.5'
gem 'oauth'
gem 'pg'
gem 'power-types'
gem 'puma', '~> 3.7'
gem 'rack-cors', '~> 0.4.0'
gem 'rails-i18n'
gem 'recipient_interceptor'
gem 'responders'
gem 'ruby-trello'
gem 'sass-rails'
gem 'sentry-raven'
gem 'simple_token_authentication', '~> 1.0'
gem 'spring'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'versionist'

group :production do
  gem 'heroku-stage'
  gem 'rack-timeout'
  gem 'rails_stdout_logging'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec_junit_formatter', '0.2.2'
  gem 'shoulda-matchers', require: false
end

group :development do
  gem 'annotate'
  gem 'letter_opener'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard-rspec', require: false
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-nc', require: false
  gem 'rspec-rails'
end

group :production, :development, :test do
  gem 'tzinfo-data'
end
