(function() {
  "use strict";

  var taskCheckBoxSubmit, datepicker_init, editTaskFormListener;

  taskCheckBoxSubmit = function() {
    return $(".js-task-checkbox").change(function() {
      return this.form.submit();
    });
  };

  datepicker_init = function() {
    $('.js-datepicker').datepicker({
      format: "dd/mm/yyyy",
      weekStart: 1,
      startDate: new Date(),
      autoclose: true
    });
  };

  editTaskFormListener = function() {
    $(document).on("click", ".edit-task-btn", function () {
      $(this).parent().hide().next(".edit-task-form").removeClass("hidden");
      return false;
    });
  }();

  $(document).ready([taskCheckBoxSubmit, datepicker_init]);

  $(document).on("page:load", taskCheckBoxSubmit, datepicker_init);

}).call(this);
