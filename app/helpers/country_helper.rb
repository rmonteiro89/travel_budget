module CountryHelper
  def countries_available
    ::Country.all
  end
end
