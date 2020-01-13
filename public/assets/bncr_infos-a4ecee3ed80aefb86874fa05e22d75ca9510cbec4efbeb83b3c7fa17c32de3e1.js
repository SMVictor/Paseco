function validateBNInfoForm() {

  var date             = document.getElementById("date");
  var company          = document.getElementById("company");
  var transfer_type    = document.getElementById("transfer_type");
  var consecutive      = document.getElementById("consecutive");
  var concept          = document.getElementById("concept");
  var account          = document.getElementById("account");
  var employee_concept = document.getElementById("employee_concept");

  var result    = true

  if (date.value == "") {
    errorHandler(date, "date_error", "Campo obligatorio");
    result = false;
  }
  if (company.value.length != 6) {
    errorHandler(company, "company_error", "6 caracteres obligatorio");
    result = false;
  }
  if (transfer_type.value == "") {
    errorHandler(transfer_type, "transfer_type_error", "Campo obligatorio");
    result = false;
  }
  if (consecutive.value.length != 6) {
    errorHandler(consecutive, "consecutive_error", "6 caracteres obligatorio");
    result = false;
  }
  if (concept.value == "") {
    errorHandler(concept, "concept_error", "Campo obligatorio");
    result = false;
  }
  if (account.value == "") {
    errorHandler(account, "account_error", "Campo obligatorio");
    result = false;
  }
  if (employee_concept.value == "") {
    errorHandler(employee_concept, "employee_concept_error", "Campo obligatorio");
    result = false;
  }
  return result;
};
