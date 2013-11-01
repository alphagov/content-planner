# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
select2Tags = ->
  $("input.select2-tags").select2(tags:[])

$(document).ready select2Tags
$(document).on "page:load", select2Tags