# Fetch data from the National Agricultural Statistics Service (NASS) Web API
class NassAPI
  include HTTParty
  base_uri 'https://quickstats.nass.usda.gov'
  default_params key: 'DECD9629-2785-3B09-B9A7-60E0557CE6BE'

  def results(options = {})
    self.class.get('/api/api_GET/', options)
  end
end
