
dashboardChart = ->
  $("#chart-container").highcharts
    chart:
      type: "bar"
      animation: false
      height: 1400

    credits:
      enabled: false

    title:
      text: "Content Plan Progress"

    xAxis:
      categories: ["PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)", "PAYE (M)", "PAYE (W)", "VAT (M)", "VAT (W)", "Self assessment (M)", "Self assessment (W)"]

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

    series: [
      name: "Published"
      data: [1, 2, 2, 2, 2, 1]
    ,
      name: "Completed"
      data: [3, 4, 4, 2, 5, 2]
    ,
      name: "In Progress"
      data: [2, 2, 3, 2, 2, 1]
    ,
      name: "Not started"
      data: [10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4, 10, 13, 14, 17, 2, 4]
    ]


$(document).ready dashboardChart
$(document).on "page:load", dashboardChart
