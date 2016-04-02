module CitiesAdapter

  def cities_gem
    ::Cities.data_path = 'lib/data/cities'
    ::Cities
  end
end
