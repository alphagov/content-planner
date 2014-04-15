(function () {
  var applyDiff = function () {
    $("section.diff").each(function () {
      GOVUK.diff($(this).attr("id"));
    });
  };

  $(document).ready(applyDiff);
  $(document).on("page:load", applyDiff);
})();
