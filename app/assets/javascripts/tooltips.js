// tooltips
// example:
// <a data-tooltip title="This is a tooltip">hover me!</a>

(function() {
  var tooltips;

  tooltips = function() {
    return $("[data-tooltip]").tooltip();
  };

  $(document).on("ready", tooltips);

  $(document).on("page:load", tooltips);

}).call(this);
