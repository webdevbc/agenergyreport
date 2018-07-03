
# json.extract! county, :id, :name, :fips, :land_area_acres
# json.extract! county, :name
# json.url county_url(county, format: :json)

# For Generating MMBtu file
json.id county.fips
json.value county.combined_mmbtus.to_i
