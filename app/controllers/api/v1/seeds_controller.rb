class Api::V1::SeedsController < ApiController
  def index
    @seeds = Seed.filter(search_params)
    render json: @seeds
  end

  private

  def search_params
    params.slice(:name)
  end
end