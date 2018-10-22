ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'helpers/custom_assert_test_helper'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
