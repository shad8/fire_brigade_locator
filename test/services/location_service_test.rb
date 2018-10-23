require 'test_helper'

class LocationServiceTest < ActiveSupport::TestCase
  Geocoder::Lookup::Test.add_stub(
      "240 Broadway, New York", [
      {
          'coordinates'  => [40.712785, -74.006073],
          'address'      => '240 Broadway, New York, USA',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
      }
  ])

  test 'should return collection of fire brigade' do
    fire_brigade = create(:fire_brigade, city: "New York", street: "90 Church St", latitude: 40.712655, longitude: -74.009914)

    params = { city: "New York", street: "240 Broadway", radius: 10 }
    result = LocationService.call(params)

    assert_equal [fire_brigade], result[:data]
  end

  test 'should return only fire brigade in radius' do
    fire_brigade_1 = create(:fire_brigade, city: "New York", street: "90 Church St", latitude: 40.712655, longitude: -74.009914)
    fire_brigade_2 = create(:fire_brigade, city: "New York", street: "Greenwich St", latitude: 40.71054, longitude: -74.011395)
    fire_brigade_3 = create(:fire_brigade, city: "Brooklyn", street: "1345 Bergen St", latitude: 40.675821, longitude: -73.940156)
    fire_brigade_4 = create(:fire_brigade, city: "New York", street: "361 Broadway", latitude: 40.717235, longitude: -74.003805)

    params = { city: "New York", street: "240 Broadway", radius: 1 }
    result = LocationService.call(params)

    assert_collections_equal [fire_brigade_1, fire_brigade_2, fire_brigade_4], result[:data]
  end

  test 'should sort fire brigades by distance' do
    fire_brigade_3 = create(:fire_brigade, city: "Brooklyn", street: "1345 Bergen St", latitude: 40.675821, longitude: -73.940156)
    fire_brigade_1 = create(:fire_brigade, city: "New York", street: "90 Church St", latitude: 40.712655, longitude: -74.009914)
    fire_brigade_2 = create(:fire_brigade, city: "New York", street: "Greenwich St", latitude: 40.71054, longitude: -74.011395)

    params = { city: "New York", street: "240 Broadway", radius: 100 }
    result = LocationService.call(params)

    assert_equal [fire_brigade_1, fire_brigade_2, fire_brigade_3], result[:data]
  end

  test 'should return empty list for no result' do
    fire_brigade_1 = create(:fire_brigade, city: "Brooklyn", street: "1345 Bergen St", latitude: 40.675821, longitude: -73.940156)

    params = { city: "New York", street: "240 Broadway", radius: 1 }
    result = LocationService.call(params)

    assert_empty result[:data]
  end

  test 'should return empty list for empty params' do
    result = LocationService.call({})

    assert_empty result[:data]
  end

  test 'should return error message when search address not found' do
    Geocoder::Lookup::Test.add_stub("Lorem ipsum, Lorem ipsum", [{}])
    params = { city: "Lorem ipsum", street: "Lorem ipsum", radius: 100 }

    result = LocationService.call(params)

    assert_equal LocationService::WRONG_ADDRESS_ERROR, result[:errors]
  end
end
