(function() {
  "use strict";

  var root = this;

  var $ = root.jQuery;

  if (typeof root.GOVUK === "undefined") {
    root.GOVUK = {};
  }

  var dmp = new diff_match_patch();
  dmp.Diff_EditCost = 6;

  root.GOVUK.diff = function(section) {
    var $a, $b, $section, htmlDiff, rawDiff;
    $section = $("#" + section);
    $a = $section.find(".previous-version");
    $b = $section.find(".current-version");
    rawDiff = dmp.diff_main($a.text(), $b.text());
    dmp.diff_cleanupEfficiency(rawDiff);
    htmlDiff = dmp.diff_prettyHtml(rawDiff);
    $a.remove();
    $b.html(htmlDiff);
  };

}).call(this);
