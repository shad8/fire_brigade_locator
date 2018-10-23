require 'test_helper'

class FireBrigadeTest < ActiveSupport::TestCase
  test 'should return the full address' do
    city = Faker::Address.city
    street = Faker::Address.street_name
    brigade = create(:fire_brigade, city: city, street: street)

    assert_equal "#{street}, #{city}", brigade.address
  end
end
