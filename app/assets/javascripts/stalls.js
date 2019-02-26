function validateStallForm() {

  var name       = document.getElementById("name");
  var customer   = document.getElementById("customer");
  var payment    = document.getElementById("payment");
  var min_salary = document.getElementById("min_salary");
  var viatical   = document.getElementById("viatical");
  var substalls  = document.getElementById("substalls");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (customer.value == "") {
    errorHandler(customer, "customer_error", "Campo obligatorio");
    result = false;
  }
  if (payment.value == "") {
    errorHandler(payment, "payment_error", "Campo obligatorio");
    result = false;
  }
  if (min_salary.value == "") {
    errorHandler(min_salary, "min_salary_error", "Campo obligatorio");
    result = false;
  }
  if (substalls.value == 0) {
    errorHandler(substalls, "substalls_error", "Campo obligatorio");
    result = false;
  }
  return result;
}