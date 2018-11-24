# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# CREATE COUNTIES (WILL ONlY RUN IF NOT IN DATABASE)
iowa_counties = [
  { fips: 19_001, name: 'Adair' },
  { fips: 19_003, name: 'Adams' },
  { fips: 19_005, name: 'Allamakee' },
  # { fips: 19_007, name: 'Appanoose' },
  # { fips: 19_009, name: 'Audubon' },
  # { fips: 19_011, name: 'Benton' },
  # { fips: 19_013, name: 'Black Hawk' },
  # { fips: 19_015, name: 'Boone' },
  # { fips: 19_017, name: 'Bremer' },
  # { fips: 19_019, name: 'Buchanan' },
  # { fips: 19_021, name: 'Buena Vista' },
  # { fips: 19_023, name: 'Butler' },
  # { fips: 19_025, name: 'Calhoun' },
  # { fips: 19_027, name: 'Carroll' },
  # { fips: 19_029, name: 'Cass' },
  # { fips: 19_031, name: 'Cedar' },
  # { fips: 19_033, name: 'Cerro Gordo' },
  # { fips: 19_035, name: 'Cherokee' },
  # { fips: 19_037, name: 'Chickasaw' },
  # { fips: 19_039, name: 'Clarke' },
  # { fips: 19_041, name: 'Clay' },
  # { fips: 19_043, name: 'Clayton' },
  # { fips: 19_045, name: 'Clinton' },
  # { fips: 19_047, name: 'Crawford' },
  # { fips: 19_049, name: 'Dallas' },
  # { fips: 19_051, name: 'Davis' },
  # { fips: 19_053, name: 'Decatur' },
  # { fips: 19_055, name: 'Delaware' },
  # { fips: 19_057, name: 'Des Moines' },
  # { fips: 19_059, name: 'Dickinson' },
  # { fips: 19_061, name: 'Dubuque' },
  # { fips: 19_063, name: 'Emmet' },
  # { fips: 19_065, name: 'Fayette' },
  # { fips: 19_067, name: 'Floyd' },
  # { fips: 19_069, name: 'Franklin' },
  # { fips: 19_071, name: 'Fremont' },
  # { fips: 19_073, name: 'Greene' },
  # { fips: 19_075, name: 'Grundy' },
  # { fips: 19_077, name: 'Guthrie' },
  # { fips: 19_079, name: 'Hamilton' },
  # { fips: 19_081, name: 'Hancock' },
  # { fips: 19_083, name: 'Hardin' },
  # { fips: 19_085, name: 'Harrison' },
  # { fips: 19_087, name: 'Henry' },
  # { fips: 19_089, name: 'Howard' },
  # { fips: 19_091, name: 'Humboldt' },
  # { fips: 19_093, name: 'Ida' },
  # { fips: 19_095, name: 'Iowa' },
  # { fips: 19_097, name: 'Jackson' },
  # { fips: 19_099, name: 'Jasper' },
  # { fips: 19_101, name: 'Jefferson' },
  # { fips: 19_103, name: 'Johnson' },
  # { fips: 19_105, name: 'Jones' },
  # { fips: 19_107, name: 'Keokuk' },
  # { fips: 19_109, name: 'Kossuth' },
  # { fips: 19_111, name: 'Lee' },
  # { fips: 19_113, name: 'Linn' },
  # { fips: 19_115, name: 'Louisa' },
  # { fips: 19_117, name: 'Lucas' },
  # { fips: 19_119, name: 'Lyon' },
  # { fips: 19_121, name: 'Madison' },
  # { fips: 19_123, name: 'Mahaska' },
  # { fips: 19_125, name: 'Marion' },
  # { fips: 19_127, name: 'Marshall' },
  # { fips: 19_129, name: 'Mills' },
  # { fips: 19_131, name: 'Mitchell' },
  # { fips: 19_133, name: 'Monona' },
  # { fips: 19_135, name: 'Monroe' },
  # { fips: 19_137, name: 'Montgomery' },
  # { fips: 19_139, name: 'Muscatine' },
  # { fips: 19_141, name: "O'Brien" },
  # { fips: 19_143, name: 'Osceola' },
  # { fips: 19_145, name: 'Page' },
  # { fips: 19_147, name: 'Palo Alto' },
  # { fips: 19_149, name: 'Plymouth' },
  # { fips: 19_151, name: 'Pocahontas' },
  # { fips: 19_153, name: 'Polk' },
  # { fips: 19_155, name: 'Pottawattamie' },
  # { fips: 19_157, name: 'Poweshiek' },
  # { fips: 19_159, name: 'Ringgold' },
  # { fips: 19_161, name: 'Sac' },
  # { fips: 19_163, name: 'Scott' },
  # { fips: 19_165, name: 'Shelby' },
  # { fips: 19_167, name: 'Sioux' },
  # { fips: 19_169, name: 'Story' },
  # { fips: 19_171, name: 'Tama' },
  # { fips: 19_173, name: 'Taylor' },
  # { fips: 19_175, name: 'Union' },
  # { fips: 19_177, name: 'Van Buren' },
  # { fips: 19_179, name: 'Wapello' },
  # { fips: 19_181, name: 'Warren' },
  # { fips: 19_183, name: 'Washington' },
  # { fips: 19_185, name: 'Wayne' },
  # { fips: 19_187, name: 'Webster' },
  # { fips: 19_189, name: 'Winnebago' },
  { fips: 19_191, name: 'Winneshiek' },
  # { fips: 19_193, name: 'Woodbury' },
  # { fips: 19_195, name: 'Worth' },
  { fips: 19_197, name: 'Wright' }
]

puts 'Creating/Updating Counties...'
iowa_counties.each do |county|
  County.find_or_create_by!(name: county[:name].upcase, state_alpha: 'IA', state_name: 'IOWA', fips: county[:fips])
end

# CREATE OR UPDATE ENERGY UNITS (set up names, emissions, btus, etc.)
energy_unit_slugs = %w[diesel gasoline electricity propane heating_oil fertilizer_n fertilizer_p fertilizer_k]

puts 'Creating/Updating Energy Units...'
energy_unit_slugs.each do |energy_unit_slug|
  e = EnergyUnit.find_or_create_by(slug: energy_unit_slug)

  case energy_unit_slug
  when 'diesel'
    e.update(
      name: 'Diesel',
      unit: 'Gallon',
      unit_short: 'gal',
      source_cost: 'eia',
      btu_per_unit: 137_381,
      source_url_btu_per_unit: 'http://www.eia.gov/energyexplained/?page=about_energy_units',
      source_text_btu_per_unit: 'U.S. EIA',
      kg_of_co2_emissions_per_unit: 10.21,
      source_url_kg_of_co2_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_co2_emissions_per_unit: 'U.S. EPA',
      kg_of_n2o_emissions_per_unit: 0.00026,
      source_url_kg_of_n2o_emissions_per_unit: 'http://www.eia.gov/oiaf/1605/coefficients.html#tbl2',
      source_text_kg_of_n2o_emissions_per_unit: 'U.S. EIA',
      kg_of_ch4_emissions_per_unit: 0.00144,
      source_url_kg_of_ch4_emissions_per_unit: 'http://www.eia.gov/oiaf/1605/coefficients.html#tbl2',
      source_text_kg_of_ch4_emissions_per_unit: 'U.S. EIA',
      eia_series_id_code: 'PET.EMD_EPD2D_PTE_R20_DPG.A', # Midwest No 2 Diesel Retail Prices, Annual (Replace 'A' with 'M' for monthly, 'W' for weekly)
      source_text_kg_of_co2e_emissions_per_unit: 'IPCC',
      source_url_kg_of_co2e_emissions_per_unit: 'https://www.ipcc.ch/publications_and_data/ar4/wg1/en/ch2s2-10-2.html'
    )
  when 'gasoline'
    e.update(
      name: 'Gasoline',
      unit: 'Gallon',
      unit_short: 'gal',
      source_cost: 'eia',
      btu_per_unit: 120_476,
      source_url_btu_per_unit: 'http://www.eia.gov/energyexplained/?page=about_energy_units',
      source_text_btu_per_unit: 'U.S. EIA',
      kg_of_co2_emissions_per_unit: 8.78,
      source_url_kg_of_co2_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_co2_emissions_per_unit: 'U.S. EPA',
      kg_of_n2o_emissions_per_unit: 0.00022,
      source_url_kg_of_n2o_emissions_per_unit: 'http://www.eia.gov/oiaf/1605/coefficients.html#tbl2',
      source_text_kg_of_n2o_emissions_per_unit: 'U.S. EIA',
      kg_of_ch4_emissions_per_unit: 0.00126,
      source_url_kg_of_ch4_emissions_per_unit: 'http://www.eia.gov/oiaf/1605/coefficients.html#tbl2',
      source_text_kg_of_ch4_emissions_per_unit: 'U.S. EIA',
      eia_series_id_code: 'PET.EMM_EPMR_PTE_R20_DPG.A', # Midwest Regular All Formulations Retail Gasoline Prices, Annual
      source_text_kg_of_co2e_emissions_per_unit: 'IPCC',
      source_url_kg_of_co2e_emissions_per_unit: 'https://www.ipcc.ch/publications_and_data/ar4/wg1/en/ch2s2-10-2.html'
    )
  when 'electricity'
    e.update(
      name: 'Electricity',
      unit: 'Kilowatthour',
      unit_short: 'kwh',
      source_cost: 'eia',
      btu_per_unit: 3414,
      source_url_btu_per_unit: 'http://www.afdc.energy.gov/fuels/fuel_comparison_chart.pdf',
      source_text_btu_per_unit: 'U.S. Department of Energy',
      kg_of_co2_emissions_per_unit: 0.6464,
      source_url_kg_of_co2_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-10/documents/egrid2012_ghgoutputrates_0.pdf',
      source_text_kg_of_co2_emissions_per_unit: 'U.S. EPA eGrid201',
      kg_of_n2o_emissions_per_unit: 0.000011004,
      source_url_kg_of_n2o_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-10/documents/egrid2012_ghgoutputrates_0.pdf',
      source_text_kg_of_n2o_emissions_per_unit: 'U.S. EPA eGrid201',
      kg_of_ch4_emissions_per_unit: 0.000012579,
      source_url_kg_of_ch4_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-10/documents/egrid2012_ghgoutputrates_0.pdf',
      source_text_kg_of_ch4_emissions_per_unit: 'U.S. EPA eGrid201',
      eia_series_id_code: 'ELEC.PRICE.IA-RES.A', # Average retail price of electricity : Iowa : residential : annual
      source_text_kg_of_co2e_emissions_per_unit: 'IPCC',
      source_url_kg_of_co2e_emissions_per_unit: 'https://www.ipcc.ch/publications_and_data/ar4/wg1/en/ch2s2-10-2.html'
    )
  when 'propane'
    e.update(
      name: 'Propane',
      unit: 'Gallon',
      unit_short: 'gal',
      source_cost: 'eia',
      btu_per_unit: 91_333,
      source_url_btu_per_unit: 'http://www.eia.gov/energyexplained/?page=about_energy_units',
      source_text_btu_per_unit: 'U.S. EIA',
      kg_of_co2_emissions_per_unit: 5.74,
      source_url_kg_of_co2_emissions_per_unit: 'http://www.eia.gov/oiaf/1605/coefficients.html#tbl2',
      source_text_kg_of_co2_emissions_per_unit: 'U.S. EIA',
      kg_of_n2o_emissions_per_unit: 0.00005,
      source_url_kg_of_n2o_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_n2o_emissions_per_unit: 'U.S. EPA',
      kg_of_ch4_emissions_per_unit: 0.00027,
      source_url_kg_of_ch4_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_ch4_emissions_per_unit: 'U.S. EPA',
      eia_series_id_code: 'PET.W_EPLLPA_PRS_SIA_DPG.W', # Iowa Propane Residential Price, Weekly (October - March)
      source_text_kg_of_co2e_emissions_per_unit: 'IPCC',
      source_url_kg_of_co2e_emissions_per_unit: 'https://www.ipcc.ch/publications_and_data/ar4/wg1/en/ch2s2-10-2.html'
    )
  when 'heating_oil'
    e.update(
      name: 'Heating Oil',
      unit: 'Gallon',
      unit_short: 'gal',
      source_cost: 'eia',
      btu_per_unit: 138_500,
      source_url_btu_per_unit: 'http://www.eia.gov/energyexplained/?page=about_energy_units',
      source_text_btu_per_unit: 'U.S. EIA',
      kg_of_co2_emissions_per_unit: 10.21,
      source_url_kg_of_co2_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_co2_emissions_per_unit: 'U.S. EPA',
      kg_of_n2o_emissions_per_unit: 0.00008,
      source_url_kg_of_n2o_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_n2o_emissions_per_unit: 'U.S. EPA',
      kg_of_ch4_emissions_per_unit: 0.00041,
      source_url_kg_of_ch4_emissions_per_unit: 'https://www.epa.gov/sites/production/files/2015-07/documents/emission-factors_2014.pdf',
      source_text_kg_of_ch4_emissions_per_unit: 'U.S. EPA',
      eia_series_id_code: 'PET.W_EPD2F_PRS_SIA_DPG.W',  # Iowa No. 2 Heating Oil Residential Price, Weekly (October - March)
      source_text_kg_of_co2e_emissions_per_unit: 'IPCC',
      source_url_kg_of_co2e_emissions_per_unit: 'https://www.ipcc.ch/publications_and_data/ar4/wg1/en/ch2s2-10-2.html'
    )
  when 'fertilizer_n'
    e.update(
      name: 'Fertilizer (N)',
      unit: 'Pound',
      unit_short: 'lb',
      eia_cost_units: 'Dollars per Pound',
      eia_cost_units_short: '$/lb',
      source_cost: 'ams',
      #             29.7 MMBtu/Ton of N (Manufacture only - Transportation not included.)
      #           / 2000
      #           = 14850
      btu_per_unit: 14_850,
      source_url_btu_per_unit: 'http://lib.dr.iastate.edu/cgi/viewcontent.cgi?article=1201&context=extension_ag_pubs',
      source_text_btu_per_unit: 'Iowa State Publication PM2089I.pdf',
      #                           = 31.3/14.7 = 2.1292517007 Mt co2 /  Mt NH3
      #                           = 2.1292517007 lb co2 / lb nh3
      #                           / 0.82
      #                           = 2.59664841546 lb co2 / lb N
      #                           = 1.177819908825246 kg co2 / lb N
      kg_of_co2_emissions_per_unit: 1.177819908825246,
      source_url_kg_of_co2_emissions_per_unit: 'http://ietd.iipnetwork.org/content/ammonia#benchmarks',
      source_text_kg_of_co2_emissions_per_unit: 'Industrial Efficiency Technology Database',
      kg_of_n2o_emissions_per_unit: 0,
      source_url_kg_of_n2o_emissions_per_unit: 'n/a',
      source_text_kg_of_n2o_emissions_per_unit: 'n/a',
      kg_of_ch4_emissions_per_unit: 0,
      source_url_kg_of_ch4_emissions_per_unit: 'n/a',
      source_text_kg_of_ch4_emissions_per_unit: 'n/a',
      source_url_kg_of_co2e_emissions_per_unit: 'http://ietd.iipnetwork.org/content/ammonia#benchmarks',
      source_text_kg_of_co2e_emissions_per_unit: 'Industrial Efficiency Technology Database'
      # Compare to...
      # https://www.sciencetheearth.com/uploads/2/4/6/5/24658156/2004_wood_a_review_of_greenhouse_gas_emission_factors.pdf
      #    1536.6 g CO2E per kg N
      #  = 1.5366 kg per kg N
      #  = 0.6969908646 kg CO2E per lb N
    )
  when 'fertilizer_p'
    e.update(
      name: 'Fertilizer (P)',
      unit: 'Pound',
      unit_short: 'lb',
      eia_cost_units: 'Dollars per Pound',
      eia_cost_units_short: '$/lb',
      source_cost: 'ams',
      # =>           -14.1 GJ/mt P2O5
      # =>         = -13364219.7 btu/mt
      # =>         / 2204.62
      #           = -6061.91529606
      btu_per_unit: -6062,
      source_url_btu_per_unit: 'http://lib.dr.iastate.edu/cgi/viewcontent.cgi?article=1201&context=extension_ag_pubs',
      source_text_btu_per_unit: 'Iowa State Publication PM2089I.pdf',
      # Look up
      # http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=82C237670C063B06D351E50C85EFFB89?doi=10.1.1.490.5451&rep=rep1&type=pdf
      # https://www.sciencetheearth.com/uploads/2/4/6/5/24658156/2004_wood_a_review_of_greenhouse_gas_emission_factors.pdf
      #                             165.1 g per kg p2o5 (Total emissions do not include Transport.)
      #                           = .1651 kg per kg P2O5
      #                           = 0.07488818935 kg per lb P2O5
      kg_of_co2_emissions_per_unit: 0.07488818935,
      source_url_kg_of_co2_emissions_per_unit: 'https://www.sciencetheearth.com/uploads/2/4/6/5/24658156/2004_wood_a_review_of_greenhouse_gas_emission_factors.pdf',
      source_text_kg_of_co2_emissions_per_unit: 'Industrial Efficiency Technology Database',
      kg_of_n2o_emissions_per_unit: 0,
      source_url_kg_of_n2o_emissions_per_unit: 'n/a',
      source_text_kg_of_n2o_emissions_per_unit: 'n/a',
      kg_of_ch4_emissions_per_unit: 0,
      source_url_kg_of_ch4_emissions_per_unit: 'n/a',
      source_text_kg_of_ch4_emissions_per_unit: 'n/a',
      source_url_kg_of_co2e_emissions_per_unit: 'http://ietd.iipnetwork.org/content/ammonia#benchmarks',
      source_text_kg_of_co2e_emissions_per_unit: 'Industrial Efficiency Technology Database'
    )
  when 'fertilizer_k'
    e.update(
      name: 'Fertilizer (K)',
      unit: 'Pound',
      unit_short: 'lb',
      eia_cost_units: 'Dollars per Pound',
      eia_cost_units_short: '$/lb',
      source_cost: 'ams',
      # Net energy consumption (balance) in manufacturing potassium chloride (muriate of potash) is 2.5 GJ/mt K2O or 0.008 gal diesel fuel energy equivalent per lb K2O.
      #           = 2369542.4697836 bt/mt
      #           / 2204.62
      #           = 1074.8076629
      btu_per_unit: 1075,
      source_url_btu_per_unit: 'http://lib.dr.iastate.edu/cgi/viewcontent.cgi?article=1201&context=extension_ag_pubs',
      source_text_btu_per_unit: 'Iowa State Publication PM2089I.pdf',
      # Look up
      # http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=82C237670C063B06D351E50C85EFFB89?doi=10.1.1.490.5451&rep=rep1&type=pdf
      kg_of_co2_emissions_per_unit: 0,
      source_url_kg_of_co2_emissions_per_unit: 'n/a',
      source_text_kg_of_co2_emissions_per_unit: 'n/a',
      kg_of_n2o_emissions_per_unit: 0,
      source_url_kg_of_n2o_emissions_per_unit: 'n/a',
      source_text_kg_of_n2o_emissions_per_unit: 'n/a',
      kg_of_ch4_emissions_per_unit: 0,
      source_url_kg_of_ch4_emissions_per_unit: 'n/a',
      source_text_kg_of_ch4_emissions_per_unit: 'n/a',
      source_url_kg_of_co2e_emissions_per_unit: 'n/a',
      source_text_kg_of_co2e_emissions_per_unit: 'n/a'
    )
  end
  e.save!
  # Calculate CO2E for all energy units...
  puts '  ' + e.name
  e.update!(
    kg_of_co2e_emissions_per_unit: e.kg_of_co2_emissions_per_unit + e.kg_of_ch4_emissions_per_unit * 25 + e.kg_of_n2o_emissions_per_unit * 298
  )
end

puts 'Downloading latest energy and fertilizer costs...'
EnergyUnit.get_latest_costs

years_of_statistics_to_download = 6
puts "Downloading #{years_of_statistics_to_download} years of NASS Statistics for #{County.count} counties... (this may take a while)"
County.find_each do |c|
  puts '  ' + c.name
  c.update_nass_statistics(years_of_statistics_to_download) # catch at least one ag census year
end

puts 'Creating crop operations...'
%w[no_tillage reduced_tillage intensive_tillage].each do |tillage_practice|
  CropOperation.find_or_create_by!(name: 'corn', rotation_practice: 'following_corn', description: 'Corn (following corn)', tillage_practice: tillage_practice)
  CropOperation.find_or_create_by!(name: 'corn', rotation_practice: 'following_soybeans', description: 'Corn (following soybeans)', tillage_practice: tillage_practice)
  CropOperation.find_or_create_by!(name: 'corn silage', description: 'Corn Silage', tillage_practice: tillage_practice)
  CropOperation.find_or_create_by!(name: 'soybeans', description: 'Soybeans', tillage_practice: tillage_practice)
  CropOperation.find_or_create_by!(name: 'forage', description: 'Forage/Haylage', tillage_practice: tillage_practice)
  CropOperation.find_or_create_by!(name: 'oats', description: 'Oats', tillage_practice: tillage_practice)
end

puts 'Creating livestock operations...'
LivestockOperation.find_or_create_by!(name: 'chickens', classification: 'broilers', description: 'Broiler Chickens')
LivestockOperation.find_or_create_by!(name: 'chickens', classification: 'layers', description: 'Laying Hens')
LivestockOperation.find_or_create_by!(name: 'hogs', description: 'Hogs')
LivestockOperation.find_or_create_by!(name: 'cattle', classification: 'beef cows', description: 'Beef Cows')
LivestockOperation.find_or_create_by!(name: 'cattle', classification: 'dairy cows', description: 'Dairy Cows')
LivestockOperation.find_or_create_by!(name: 'cattle', classification: 'other', description: 'Calves, Steers, & Bulls')

puts 'Creating Steps and Assigning Steps to Operations'
Operation.all.each do |operation|
  operation.steps.delete_all
  operation.import_steps
  # Update cached values for energy_dollars, co2e_emissions, fertilizer_dollars, drying_dollars, field_dollars, etc.
  operation.save
  operation.update_cached_values
end

puts 'Updating attributes for all counties with latest statistics)...'
County.find_each(&:update_cached_values)


# puts 'Initializing Crop and Livestock Inventories'
# County.find_each(&:initialize_inventories)
#
# puts 'Updating Inventories...'
# County.find_each(&:update_inventories)
# puts 'Seed Process Complete.'
