class Api::V1::SeedCatalogsController < ApiController
  before_action :authenticate_user!

  def create
    seed_catalog = current_user.seed_catalogs.create!(seed_catalog_params)
    render json: seed_catalog, status: :created
  end

  def index
    seed_catalogs = current_user.seed_catalogs.all
    render json: seed_catalogs
  end

  def update
    seed_catalog = current_user.seed_catalogs.find(params[:id])
    if seed_catalog.update(seed_catalog_params)
      render json: seed_catalog
    else
      render json: {errors: 'Invalid attributes'}, status: :unprocessable_entity
    end
  end

  def destroy
    seed_catalog = current_user.seed_catalogs.find(params[:id])
    message = "#{seed_catalog.seed.name} has been removed from your catalog"
    seed_catalog.destroy!
    render json: {message: message}
  end

  private

  def seed_catalog_params
    params.require(:seed_catalog).permit(:seed_id, :planted)
  end
end