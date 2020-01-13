function validatePositionForm() {

  var name       = document.getElementById("name");
  var salary     = document.getElementById("salary");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (salary.value == "") {
    errorHandler(salary, "salary_error", "Campo obligatorio");
    result = false;
  }
  if (area.value == "") {
    errorHandler(area, "area_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

$( document ).on('turbolinks:load', function() {
  onInput("area");
}); 
