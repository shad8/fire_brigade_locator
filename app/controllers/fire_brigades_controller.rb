class FireBrigadesController < ApplicationController
  def index
    results = LocationService.call(params)
    @fire_brigades = results[:data]
    flash[:error] = results[:errors]
  end
end
