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

    @url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    # @street_address = @street_address.to_s.gsub(/[^a-z0-9\s]/i, "")
    
    @street_address_with_spaces = []
    
    @street_address_to_array = @street_address.split
    
    @street_address_to_array.each do |word|
      new_word = word + "+"
      @street_address_with_spaces.push(new_word)
    end
    
    @street_address_with_spaces = @street_address_with_spaces.to_s
    
    @google_url = @url + @street_address_with_spaces + "&key=AIzaSyDNqz-qn2W4rtt6pVaNwlw3nWYOgyzDHiw"
    
    parsed_data = JSON.parse(open(@google_url).read)

    
    @url2 = "https://api.darksky.net/forecast/e2aa6d7072480eda19a1483312f8c884/"

    # @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    @latitude = parsed_data.dig("results",0,"geometry","location","lat").to_s

    # @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s
    @longitude = parsed_data.dig("results",0,"geometry","location","lng").to_s
    
    @darksky_url = @url2 + @latitude + "," + @longitude
    
    parsed_data2 = JSON.parse(open(@darksky_url).read)

    

    @current_temperature = parsed_data2.dig("currently","temperature")

    @current_summary = parsed_data2.dig("currently","summary")

    @summary_of_next_sixty_minutes = parsed_data2.dig("minutely","summary")

    @summary_of_next_several_hours = parsed_data2.dig("hourly","summary")

    @summary_of_next_several_days = parsed_data2.dig("daily","summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end
