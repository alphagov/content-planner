(function () {
  var applyDiff = function () {
    $("section.diff").each(function () {
      GOVUK.diff($(this).attr("id"));
    });
  };

  $(document).ready(function() {
    applyDiff();

    $(".contents_container table").tablesorter({
      cssAsc: "sort-ascending",
      cssDesc: "sort-descending",
      cssHeader: "sort-header",
      sortList: [[0,0]]
    });
  });

  $(document).on("page:load", applyDiff);
})();
