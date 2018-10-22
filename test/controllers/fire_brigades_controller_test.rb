require 'test_helper'

class FireBrigadesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get fire_brigades_index_url
    assert_response :success
  end
end
