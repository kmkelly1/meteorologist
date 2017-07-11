require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
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
    
  

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    render("geocoding/street_to_coords.html.erb")
  end
end
