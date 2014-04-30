(function() {
  var taskCheckBoxSubmit;

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

  $(document).ready([taskCheckBoxSubmit, datepicker_init]);

  $(document).on("page:load", [taskCheckBoxSubmit, datepicker_init]);

}).call(this);
