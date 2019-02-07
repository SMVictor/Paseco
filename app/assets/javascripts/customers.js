function validateCreateForm() {

  var tradename = document.getElementById("tradename");
  var result    = true

  if (tradename.value == "") {
    errorHandler(tradename, "tradename_error", "Campo obligatorio");
    result = false;
  }
  return result;
}
function onInput(id){
  $('#'+id).on('input', function() {
    var element = document.getElementById(""+id);
    var element_error =  document.getElementById(id+"_error");

    element_error.innerHTML = "";
    element.style.borderColor = "#D9ECEC";
    
  });
}

function enableSubmitButtom() {
  document.getElementById("btn_submit").disabled = false;
}

function errorHandler(field, field_error_name, message){

  var field_error =  document.getElementById(field_error_name);

  field.style.border         = "1px solid";
  field.style.borderColor    = "#D36038";
  field_error.innerHTML      = message;
  field_error.style.color    = "#D36038";
  field_error.style.fontSize = "0.8rem";

  setTimeout(enableSubmitButtom, 1000);

}