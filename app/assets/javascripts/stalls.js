function validateStallForm() {

  var name       = document.getElementById("name");
  var stall   = document.getElementById("stall");
  var payment    = document.getElementById("payment");
  var min_salary = document.getElementById("min_salary");
  var viatical   = document.getElementById("viatical");
  var substalls  = document.getElementById("substalls");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (stall.value == "") {
    errorHandler(stall, "stall_error", "Campo obligatorio");
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

function filterStall(){
  var stalls = JSON.parse(document.querySelector('#stall').dataset.stalls);
  var search = $('#stall').val().toUpperCase();
  var ids = [0];
  stalls.forEach(function(stall) {
    if (stall.name.toUpperCase().includes(search)) {
      ids.push(stall.id);
    }
  });
  $.ajax({
    type: "GET",
    url: "/admin/stalls/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}
function filterInactiveStalls(){
  var stalls = JSON.parse(document.querySelector('#stall').dataset.stalls);
  var search = $('#stall').val().toUpperCase();
  var ids = [0];
  stalls.forEach(function(stall) {
    if (stall.name.toUpperCase().includes(search)) {
      ids.push(stall.id);
    }
  });
  $.ajax({
    type: "GET",
    url: "/admin/inactive/stalls/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}