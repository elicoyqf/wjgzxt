# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  myChart = new FusionCharts('/FusionCharts/Scatter.swf', 'myChart2', 4000, 300)
  myChart.setJSONUrl('/graphs/data_json.json')
  myChart.render('myFirstJson')