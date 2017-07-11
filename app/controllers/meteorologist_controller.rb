require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

     @url = "http://maps.googleapis.com/maps/api/geocode/json?address="
    
    @street_address_with_spaces = []
    
    @street_address = @street_address.split
    
    @street_address.each do |word|
      new_word = word + "+"
      @street_address_with_spaces.push(new_word)
    end
    
    @street_address_with_spaces = @street_address_with_spaces.to_s
    
    @google_url = @url + @street_address_with_spaces
    
    parsed_data = JSON.parse(open(@google_url).read)
      # latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
      # longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    
    @url2 = "https://api.darksky.net/forecast/e2aa6d7072480eda19a1483312f8c884/"

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s
    
    @darksky_url = @url2 + @latitude + "," + @longitude
    
    parsed_data2 = JSON.parse(open(@darksky_url).read)

    

    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
