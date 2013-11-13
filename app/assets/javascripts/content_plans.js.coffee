# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
applyDiff = ->
  $("section.diff").each (index) ->
    GOVUK.diff $(this).attr("id")

$(document).ready applyDiff
$(document).on "page:load", applyDiff
