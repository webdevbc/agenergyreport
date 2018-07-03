desc 'This task is called by the Heroku scheduler add-on and updates fuel and fertilizer price data'
task update_fuels: :environment do
  puts 'Updating fuel and fertilizer prices...'
  EnergyUnit.get_latest_costs
  # TODO: run sweeper and update page caches
  puts 'Task Complete.'
end

desc 'Download NASS Statistics and create local statistics'
task update_statistics: :environment do
  puts 'Downloading NASS Statistics... (this may take a while)'
  County.find_each do |c|
    puts c.title
    c.update_nass_statistics(1) # Last 1 year worth of stats
  end
  puts 'NASS Statistics Downloaded. Task Complete'
end

desc 'Updates all counties with the latest land use/acreage data as well as data from head count/acre statistics '
task update_counties: :environment do
  puts 'Updating attributes for all counties with latest statistics)...'
  County.find_each do |c|
    c.update(
      land_area_acres: c.statistics.total_land_area.latest.first.value_float.to_i,
      land_area_acres_year: c.statistics.total_land_area.latest.first.year,
      cropland_acres: c.statistics.cropland.first.value_float.to_i,
      cropland_acres_year: c.statistics.cropland.first.year,
      cropland_harvested_acres: c.statistics.cropland_harvested.first.value_float.to_i,
      cropland_harvested_acres_year: c.statistics.cropland_harvested.first.year,
      pastureland_acres: c.statistics.pastureland.first.value_float.to_i,
      pastureland_acres_year: c.statistics.pastureland.first.year,
      woodland_acres: c.statistics.woodland.first.value_float.to_i,
      woodland_acres_year: c.statistics.woodland.first.year,
      other_agland_acres: c.statistics.other_agland.first.value_float.to_i,
      other_agland_acres_year: c.statistics.other_agland.first.year,
      total_farm_operations_count: c.statistics.total_farm_operations.first.value_float.to_i,
      total_farm_operations_count_year: c.statistics.total_farm_operations.first.year,
      corn_grain_acres: (c.statistics.corn_grain.exists? ? c.statistics.corn_grain.first.value_float.to_i : nil),
      corn_silage_acres: (c.statistics.corn_silage.exists? ? c.statistics.corn_silage.first.value_float.to_i : nil),
      soybeans_acres: (c.statistics.soybeans.exists? ? c.statistics.soybeans.first.value_float.to_i : nil),
      oats_acres: (c.statistics.oats.exists? ? c.statistics.oats.first.value_float.to_i : nil),
      forage_acres: (c.statistics.forage.exists? ? c.statistics.forage.first.value_float.to_i : nil),
      beef_cows: (c.statistics.beef_cows.exists? ? c.statistics.beef_cows.first.value_float.to_i : nil),
      milk_cows: (c.statistics.milk_cows.exists? ? c.statistics.milk_cows.first.value_float.to_i : nil),
      other_cattle: (c.statistics.other_cattle.exists? ? c.statistics.other_cattle.first.value_float.to_i : nil),
      hogs: (c.statistics.hogs.exists? ? c.statistics.hogs.first.value_float.to_i : nil),
      broilers: (c.statistics.broilers.exists? ? c.statistics.broilers.first.value_float.to_i : nil),
      layers: (c.statistics.layers.exists? ? c.statistics.layers.first.value_float.to_i : nil)
    )
  end
  puts 'Task Complete.'
end
