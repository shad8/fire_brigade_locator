class LocationService
  include Service

  WRONG_ADDRESS_ERROR = 'Address not found'.freeze

  def call(params)
    results = { data: [], errors: nil }

    return results unless params[:city] && params[:street] && params[:radius]

    address = [params[:street], params[:city]].join(', ')
    coordinates = Geocoder.coordinates(address)

    if coordinates
      results[:data] = FireBrigade.near(coordinates, params[:radius], order: 'distance')
    else
      results[:errors] = WRONG_ADDRESS_ERROR
    end

    results
  end
end
