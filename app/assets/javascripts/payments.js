function validatePaymentForm() {

  var name = document.getElementById("name");
  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  return result;
}