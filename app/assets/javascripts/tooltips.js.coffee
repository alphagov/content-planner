# tooltips
# example:
# <a data-tooltip title="This is a tooltip">hover me!</a>

tooltips = ->
  $("[data-tooltip]").tooltip()

$(document).on "ready", tooltips
$(document).on "page:load", tooltips
