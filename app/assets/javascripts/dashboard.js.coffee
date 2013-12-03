dashboardChart = ->
  defaults =
    chart:
      type: "bar"
      animation: false
      height: 1400
      renderTo: 'chart-container'

    credits:
      enabled: false

    title:
      text: "Content Plan Progress"

    yAxis:
      min: 0
      title:
        text: "Points"

    legend:
      backgroundColor: "#FFFFFF"
      reversed: true

    plotOptions:
      series:
        stacking: "normal"

    series: [{}]
  if $("#chart-container").length is 1
    $.getJSON "/dashboard_data", (data) ->
      settings = $.extend({}, defaults, data)
      new Highcharts.Chart(settings)

$(document).ready dashboardChart
$(document).on "page:load", dashboardChart
