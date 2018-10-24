class AddressesController < ApplicationController
  def show
    update_address_from_pool unless current_user.address.present?
  end

  def create
    update_address_from_pool

    render 'show'
  end

  protected
  def update_address_from_pool
    service = AddressPoolFetchService.new(current_user)
    service.call
    if service.error.present?
      AddressPoolRegenerateService.new.call
      flash.now[:alert] = service.error
    end
  end
end
