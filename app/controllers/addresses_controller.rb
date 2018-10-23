class AddressesController < ApplicationController
  RUN_INTERVAL = 12.minutes

  def show
    update_address_from_pool unless current_user.address.present?
  end

  def create
    update_address_from_pool

    render 'show'
  end

  protected
  def next_run
    time = Time.current
    passed = (time.to_f % RUN_INTERVAL).round
    RUN_INTERVAL - passed
  end

  def show_empty_pool_notice
    flash.now[:notice] = "Address Pool empty, please try again in #{next_run / 60} Minutes and #{next_run % 60} Seconds"
  end

  def update_address_from_pool
    unless AddressPoolFetchService.new(current_user).call
      AddressPoolRegenerateService.new.call
      show_empty_pool_notice
    end
  end
end
