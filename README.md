# Ag Energy Report

An open source, Ruby on Rails web application that estimates energy use in the agricultural sector.

Visit the Ag Energy Report for Iowa at: https://agreport.energydistrict.org

The model takes into account crop acreage and livestock estimates at the county level, pulls in data on the amount of fuel, electricity, and fertilizer used in crop and livestock production, and outputs agricultural energy use in terms of dollars, MMBtus, and emissions. Data sources include the USDA - National Agricultural Statistics Service Census of Agriculture & Annual Surveys, Iowa State University, the U.S. Energy Information Administration, U.S. Environmental Protection Agency, USDA Market News, and others.

Built using [Ruby on Rails](https://rubyonrails.org), [PostgreSQL](https://www.postgresql.org), [Bootstrap 4](https://getbootstrap.com), [Highcharts](https://www.highcharts.com), and [AmCharts](https://www.amcharts.com/javascript-maps/).


## Installation
Steps to get the development application up and running at http://localhost:3000

* Install Ruby 2.6.5 or greater
* Install Ruby on Rails 5.2.3 or greater
* Install PostgreSQL 10 or greater (e.g., [Postgres.app on the Mac](https://postgresapp.com))

```
git clone https://github.com/webdevbc/agenergyreport.git
cd agenergyreport
bundle install
rake db:setup
rails server
```

* Asset precompilation may be necessary on some hosts
```
rake assets:precompile
```


## About the Project
*A project of the [Winneshiek Energy District](https://energydistrict.org) with funding provided through a [NRCS Conservation Innovation Grant](https://www.nrcs.usda.gov/wps/portal/nrcs/main/national/programs/financial/cig/)*
