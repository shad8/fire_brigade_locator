require 'test_helper'

class FireBrigadesControllerTest < ActionDispatch::IntegrationTest
  Geocoder::Lookup::Test.add_stub(
    '240 Broadway, New York', [
      {
        'coordinates' => [40.712785, -74.006073],
        'address'      => '240 Broadway, New York, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )

  test 'should redirect to index action for FireBrigade Controller' do
    get root_path

    assert_response :success
    assert_template :index
    assert_instance_of FireBrigadesController, @controller
  end

  test 'should return empty collection when not search params set' do
    get root_path

    assert_response :success
    assert_template :index
    assert_empty assigns(:fire_brigades)
  end

  test 'should return collection when search params set' do
    fire_brigade = create(:fire_brigade, city: 'New York', street: '90 Church St', latitude: 40.712655, longitude: -74.009914)
    params = { city: 'New York', street: '240 Broadway', radius: 1 }

    get root_path, params: params

    assert_response :success
    assert_template :index
    assert_equal [fire_brigade], assigns(:fire_brigades)
  end

  test 'should return error message when search address not found' do
    Geocoder::Lookup::Test.add_stub('Lorem ipsum, Lorem ipsum', [{}])

    params = { city: 'Lorem ipsum', street: 'Lorem ipsum', radius: 100 }

    get root_path, params: params

    assert_equal LocationService::WRONG_ADDRESS_ERROR, flash[:error]
  end
end
