(function() {
  "use strict";

  var taskCheckBoxSubmit, datepicker_init, editTaskFormListener, showCompletedTasksListener;

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
  };

  showCompletedTasksListener = function() {
    $(document).on("click", ".show_completed_tasks", function () {
      $(this).remove();
      $(".completed-tasks.hidden").removeClass("hidden");
      return false;
    })
  };

  editTaskFormListener();
  showCompletedTasksListener();

  $(document).ready([taskCheckBoxSubmit, datepicker_init]);

  $(document).on("page:load", taskCheckBoxSubmit, datepicker_init);

}).call(this);
