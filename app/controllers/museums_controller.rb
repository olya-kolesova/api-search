require 'json'
require 'open-uri'

class MuseumsController < ApplicationController

  def create
    @museum = Museum.new(museum_params)
    longitude = museum_params[:longitude].to_f
    latitude = museum_params[:latitude].to_f
    url = "https://api.mapbox.com/geocoding/v5/mapbox.places/museum.json?proximity=#{longitude},#{latitude}&limit=5&access_token=pk.eyJ1Ijoib2xrYS1rb2xlc292YSIsImEiOiJja3M4cWo4YnAweGhyMm5vY2lscDltZGRiIn0.hHvSngIBf1BXB5bs8lF37A"
    museum_serialized = URI.open(url).read
    museum = JSON.parse(museum_serialized)
    Museum.destroy_all
    museum["features"].each do |item|
      Museum.create(name: item['text'], zip_code: item['context'].first['text'])
    end
    redirect_to museums_path
  end

  def index
    @museum = Museum.new
    @museums = Museum.all
  end


  def museum_params
    params.require(:museum).permit(:longitude, :latitude)
  end
end
