(function () {
  var applyDiff = function () {
    $("section.diff").each(function () {
      GOVUK.diff($(this).attr("id"));
    });
  };

  var activateDatatables = function() {
    $('.datatable').each(function() {
      $(this).dataTable({
        sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        sPaginationType: "bootstrap",
        bProcessing: true,
        bServerSide: true,
        sAjaxSource: $(this).data('source'),
        searching: false,
        lengthChange: false,
        pageLength: 7
      });
    });
  };

  $(document).ready(function() {
    applyDiff();

    activateDatatables();
  });

  $(document).on("page:load", applyDiff);
})();
