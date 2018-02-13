class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :address_search]
  def index
    @places = GoogleMapsService.nearby_places 33131
    Rails.logger.info @places

  end

  def show
    @places = GoogleMapsService.nearby_places 33131
    Rails.logger.info @places

  end

  def address_search
    @response = GoogleMapsService.nearby_places(params[:search])
    render 'maps/index', response: @response
  end

end
