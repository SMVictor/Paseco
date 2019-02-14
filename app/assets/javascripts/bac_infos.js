function validateBacInfoForm() {

  var date             = document.getElementById("date");
  var plan             = document.getElementById("plan");
  var shipping         = document.getElementById("shipping");
  var concept          = document.getElementById("concept");

  var result = true

  if (date.value == "") {
    errorHandler(date, "date_error", "Campo obligatorio");
    result = false;
  }
  if (plan.value == "") {
    errorHandler(plan, "plan_error", "Campo obligatorio");
    result = false;
  }
  if (shipping.value.length != 5) {
    errorHandler(shipping, "shipping_error", "5 caracteres obligatorio");
    result = false;
  }
  if (concept.value == "") {
    errorHandler(concept, "concept_error", "Campo obligatorio");
    result = false;
  }
  return result;
}
