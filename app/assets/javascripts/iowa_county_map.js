/**
 * Create the index map
 */

var map = AmCharts.makeChart("chartdiv", {
  "type": "map",
  "theme": "light",
  "colorSteps": 14,
  "dataProvider": {
    "map": "iowaHigh",
    "getAreasFromMap": true,
    "areas": county_mmbtus
  },
  "areasSettings": {
    "autozoom": false,
    "selectedColor": "#CC0000",
    "selectable": true
  },
  "zoomControl": {
    "panStepSize": 1,
    "maxZoomLevel": 2
  },
  "valueLegend": {
    "right": 10,
    "minValue": "– \xa0\xa0\xa0\xa0 Agricultural Energy Use",
    "maxValue": "+"
  },

  /**
   * Add click event to track county selection/unselection
   */
  "listeners": [{
    "event": "clickMapObject",
    "method": handleClick
  }]
});

function handleClick(e) {

  // Ignore any click not on area
  if (e.mapObject.objectType !== "MapArea")
    return;

  var area = e.mapObject;

  // Toggle showAsSelected
  area.showAsSelected = !area.showAsSelected;
  e.chart.returnInitialColor(area);

  // Update the hidden field
  document.getElementById("selectedCounties").value = JSON.stringify(getSelectedCounties());

  // Update the list
  document.getElementById("selected").innerHTML = getSelectedCountyNames();
}

/**
 * Function which extracts currently selected county list.
 * Returns array consisting of county FIPS codes
 */
function getSelectedCounties() {
  var selected = [];
  for (var i = 0; i < map.dataProvider.areas.length; i++) {
    if (map.dataProvider.areas[i].showAsSelected)
      selected.push(map.dataProvider.areas[i].id);
  }
  return selected;
}

function getSelectedCountyNames() {
  var selected = [];
  for (var i = 0; i < map.dataProvider.areas.length; i++) {
    if (map.dataProvider.areas[i].showAsSelected)
      selected.push(" " + map.dataProvider.areas[i].title);
  }
  return selected;
}
