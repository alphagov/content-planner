(function () {
  var updateCountdown = function (input) {
    var string = input.val().substring(0, 255);
    input.val(string);

    var remaining = 255 - string.length;
    var counter = input.parents('.field_with_counter').find(".countdown");
    counter.text(remaining + ' characters remaining');
  }

  var updateCountdowns = function () {
    $(".string_with_counter").each(function() {
      updateCountdown($(this));
    });
  }

  $(document).on("change keyup", ".string_with_counter", function () {
    updateCountdown($(this));
  });

  $(document).ready(updateCountdowns);
  $(document).on("page:load", updateCountdowns);
})();