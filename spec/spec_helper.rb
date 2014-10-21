# spec/spec_helper.rb
require 'rack/test'
require 'pry'
require 'database_cleaner'
require 'factory_girl'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../lib/ernest.rb', __FILE__

require 'simplecov'
SimpleCov.start

ActiveRecord::Base.logger.level = 1

module RSpecMixin
  include Rack::Test::Methods
  def app() Ernest end
end

RSpec.configure do |config|

  config.include RSpecMixin
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
