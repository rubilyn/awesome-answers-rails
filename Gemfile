#this file is used by the `Bundler` gem to manage the gems needed for our Rails project.
#

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'



# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'faker', github: 'stympy/faker'
gem 'cowsay'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'rack-cors'

gem 'bcrypt', '~> 3.1.7'
gem 'cancancan', '~> 1.10'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap-glyphicons'
gem 'rails-erd'
gem 'rspec-rails', '~>3.5'
gem 'rails-controller-testing'
gem "font-awesome-rails"
gem 'font-awesome-sass'
gem 'truncate_html', '~> 0.3.2'
gem 'jquery-rails'
gem 'delayed_job_active_record'
gem 'delayed_job_web'
gem 'active_model_serializers'
gem 'chosen-rails'
gem 'simple_form'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'fog'
gem 'friendly_id', github: 'norman/friendly_id'
gem 'omniauth-twitter'
gem 'twitter'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

end

group :development do
  gem 'interactive_editor'
  gem 'awesome_print'
  gem 'hirb'
  gem 'letter_opener'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
