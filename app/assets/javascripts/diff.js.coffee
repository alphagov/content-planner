(->
  "use strict"
  root = this
  $ = root.jQuery
  root.GOVUK = {}  if typeof root.GOVUK is "undefined"
  dmp = new diff_match_patch()
  dmp.Diff_EditCost = 6
  root.GOVUK.diff = (section) ->
    $section = $("#" + section)
    $a = $section.find(".previous-version")
    $b = $section.find(".current-version")
    rawDiff = dmp.diff_main($a.text(), $b.text())
    dmp.diff_cleanupEfficiency rawDiff
    htmlDiff = dmp.diff_prettyHtml(rawDiff)
    $a.remove()
    $b.html htmlDiff
).call this