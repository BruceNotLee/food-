class GoogleMapsService
  @@google_key = ENV['GOOGLE_KEY']
  @@place_id
  class << self
    def root_path
      'https://maps.googleapis.com/maps/api/'
    end

    def nearby_places(zip)
      url_path = root_path + 'place/nearbysearch/json?'

      params ="location=#{geo_location(zip)}&radius=16093&type=restaurant&key=#{@@google_key}"

      response = RestClient.get(url_path+params)

      response_body = JSON.parse(response.body)

      response_body['results']
    end

    def geo_location(zip)
      url_path = root_path + 'geocode/json?'

      response = RestClient.get(url_path + "components=postal_code:#{zip}")
      response_body = JSON.parse(response.body)

      location = response_body['results'][0]['geometry']['location']

      "#{location['lat']},#{location['lng']}"
    end

    def place_details(placeid)
      root_path = "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{placeid}&key=#{@@google_key}"

      response = RestClient.get(root_path)

      return JSON.parse(response.body)
    end
  end
end
