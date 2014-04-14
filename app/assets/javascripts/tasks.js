(function() {
  var taskCheckBoxSubmit;

  taskCheckBoxSubmit = function() {
    return $(".js-task-checkbox").change(function() {
      return this.form.submit();
    });
  };

  $(document).ready(taskCheckBoxSubmit);

  $(document).on("page:load", taskCheckBoxSubmit);

}).call(this);
