function validateHolidayForm() {

  var date        = document.getElementById("date");
  var name = document.getElementById("name");
  var result      = true

  if (date.value == "") {
    errorHandler(date, "date_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

$( document ).on('turbolinks:load', function() {
  onInput("date");
}); 