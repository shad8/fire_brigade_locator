class FireBrigadesController < ApplicationController
  def index
    @fire_brigades = LocationService.call(params)
  end
end
