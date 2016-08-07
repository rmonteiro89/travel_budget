class CitiesController < ApplicationController

  def index
    cities = []
    if params[:country_name]
      cities = find_cities_by_country_name(params[:country_name])
    end

    render json: cities
  end

  private

  def find_cities_by_country_name(country_name)
    country_code = country_code_by_country_name(country_name)
    find_cities_by_country_code(country_code)
  end

  def country_code_by_country_name(country_name)
    country = ISO3166::Country.find_country_by_name(country_name)
    country.alpha2
  end

  def find_cities_by_country_code(country_code)
    Cities.data_path = 'lib/data/cities'
    Cities.cities_in_country(country_code).values.map(&:name)
  end
end
