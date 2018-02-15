class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :address_search]
  def index
    unless params[:search].nil?
      p params[:search]
      @places = GoogleMapsService.nearby_places params[:search]
      @meals =  Unsplash::Photo.search("food")
      @local_resturants = @places.map do |r|
        pd = GoogleMapsService.place_details(r['place_id'])['result']
        {
          id: r['place_id'],
          name: r['name'],
          opening_hours: r['opening_hours'],
          details: {
            types: pd['types'],
            vicinity: pd['vicinity']
          }
        }
      end
    end
    Rails.logger.info @places
  end

  def show
    @places = GoogleMapsService.nearby_places
    Rails.logger.info @places
  end

end
