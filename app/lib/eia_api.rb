# Fetch data from the U.S. Energy Information Administration (EIA) Web API
# http://www.eia.gov/opendata/index.cfm
class EiaAPI
  include HTTParty
  base_uri 'http://api.eia.gov/'
  default_params api_key: '55DFD284F5021FFCE8B3A41F866392BE'

  # Used to fetch results
  # e.g. EiaAPI.new.results({query: {series_id: 'PET.EMD_EPD2D_PTE_R20_DPG.W', num: 1}}).parsed_response['series']
  def results(options = {})
    self.class.get('/series/', options)
  end
end
