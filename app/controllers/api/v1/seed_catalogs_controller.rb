class Api::V1::SeedCatalogsController < ApiController
  before_action :authenticate_user!

  def create
    seed_catalog = current_user.seed_catalogs.create!(seed_catalog_params)
    render json: seed_catalog, status: :created
  end

  private

  def seed_catalog_params
    params.require(:seed_catalog).permit(:seed_id)
  end
end