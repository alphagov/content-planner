# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
taskCheckBoxSubmit = ->
  $(".js-task-checkbox").change ->
    @form.submit()

$(document).ready taskCheckBoxSubmit
$(document).on "page:load", taskCheckBoxSubmit