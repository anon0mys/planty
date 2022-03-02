class Api::V1::HardinessZonesController < ApiController
  def search
    zone = HardinessZone.filter(search_params)
    render json: zone
  end

  private

  def search_params
    search_params = params.slice(:zipcode) || params.slice(:city, :state)
    if search_params.empty?
      raise Exceptions::MissingSearchParam,
        "Hardiness Zone search requires zipcode or city, state"
    end
    search_params
  end
end