function validateAreaForm() {

  var name        = document.getElementById("name");
  var description = document.getElementById("description");
  var result      = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

$( document ).on('turbolinks:load', function() {
  onInput("name");
}); 
