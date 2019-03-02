function validateRoleForm() {

  var name       = document.getElementById("name");
  var start_date = document.getElementById("start_date");
  var end_date   = document.getElementById("end_date");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (start_date.value == "") {
    errorHandler(start_date, "start_date_error", "Campo obligatorio");
    result = false;
  }
  if (end_date.value == "") {
    errorHandler(end_date, "end_date_error", "Campo obligatorio");
    result = false;
  }
  return result;
}
function changeIconColor(){
  var inputs = document.getElementsByClassName("hours");
  var buttons = document.getElementsByName("btn_modal");

  for (var i = 0; i < inputs.length; i++) {
    if (inputs[i].value != "") {
      buttons[i].style.color = "#5DC973";
    }
    else{
      buttons[i].style.color = "#8068D9";
    }
  }
}