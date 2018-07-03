Highcharts.theme = {
  colors: ['#1997c6', '#40C0CB', '#AEE239', '#8FBE00',
    '#FF9655', '#FFF263', '#6AF9C4'
  ],
  title: {
    style: {
      color: '#000',
      font: '16px Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif'
    }
  },
  subtitle: {
    style: {
      color: '#666666',
      font: '12px Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif'
    }
  },

  legend: {
    itemStyle: {
      font: '9pt Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif',
      color: 'black'
    },
    itemHoverStyle: {
      color: 'gray'
    }
  },

  lang: {
    thousandsSep: ','
  }
};

// Apply the theme
Highcharts.setOptions(Highcharts.theme);
