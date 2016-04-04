class CurrenciesController < ApplicationController

  def index
    currencies = []
    if params[:country_name]
      currencies = [{code: by_country_name(params[:country_name]).code}]
    end

    render json: currencies
  end

  private
  def by_country_name(country_name)
    country = ISO3166::Country.find_country_by_name(country_name)
    country.currency if country
  end
end
