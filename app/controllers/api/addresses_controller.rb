class Api::AddressesController < Api::BaseController
  def show
    render json: current_user.as_json(only: [:id, :address])
  end

  def create
    service = AddressPoolFetchService.new(current_user)
    service.call
    if service.error.present?
      render json: {error: service.error}, status: 400
    else
      render json: current_user.as_json(only: [:id, :address])
    end
  end
end
