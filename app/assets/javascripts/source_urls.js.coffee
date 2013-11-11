# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jsTags = ->
  $("input.js-tags").select2
    tags: true
    initSelection: (element, callback) ->
      data = []
      $(element.val().split(",")).each ->
        data.push
          id: $.trim(this)
          text: $.trim(this)
      callback data
    ajax:
      url: "/tags"
      dataType: "json"
      data: (term, page) ->
        q: term
        page: page

      results: (data, page) ->
        results: data


jsContentPlans = ->
  $("#source_url_content_plan_ids").select2();


$(document).ready jsTags
$(document).on "page:load", jsTags

$(document).ready jsContentPlans
$(document).on "page:load", jsContentPlans