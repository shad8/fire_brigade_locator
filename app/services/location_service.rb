class LocationService
  include Service

  def call(params)
    return [] unless params[:city] && params[:street] && params[:radius]
    address = [params[:street], params[:city]].join(', ')
    FireBrigade.near(address, params[:radius], order: 'distance')
  end
end