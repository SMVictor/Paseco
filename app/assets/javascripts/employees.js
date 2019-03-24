function validateEmployeeForm() {

  var name            = document.getElementById("name");
  var identification  = document.getElementById("identification");
  var selectRole      = document.getElementById("selectRole");
  var stalls          = document.getElementById("stalls");
  var payment_method  = document.getElementById("payment_method");
  var bank            = document.getElementById("bank");
  var account         = document.getElementById("account");
  var social_security = document.getElementById("social_security");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (identification.value == "") {
    errorHandler(identification, "identification_error", "Campo obligatorio");
    result = false;
  }
  else{
    identification.value = identification.value.replace(/-/g,'');
  }
  if (selectRole.value == "") {
    errorHandler(selectRole, "selectRole_error", "Campo obligatorio");
    result = false;
  }
  if (stalls.value == "") {
    errorHandler(stalls, "stalls_error", "Campo obligatorio");
    result = false;
  }
  if (payment_method.value == "") {
    errorHandler(payment_method, "payment_method_error", "Campo obligatorio");
    result = false;
  }
  if (bank.value == "") {
    errorHandler(bank, "bank_error", "Campo obligatorio");
    result = false;
  }
  else{
    account.value = account.value.replace(/-/g,'');
  }
  if (social_security.value == "") {
    errorHandler(social_security, "social_security_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

function filterEmployee(){
  var employees = JSON.parse(document.querySelector('#employee').dataset.employees);
  var search = $('#employee').val().toUpperCase();
  var ids = [0];
  employees.forEach(function(employee) {
    if (employee.name.toUpperCase().includes(search) || employee.identification.includes(search)) {
      ids.push(employee.id);
    }
  });
  $.ajax({
    type: "GET",
    url: "/admin/employees/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}