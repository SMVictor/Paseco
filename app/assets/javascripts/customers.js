function validateCustomerForm() {

  var business_name       = document.getElementById("business_name");
  var tradename           = document.getElementById("tradename");
  var legal_document      = document.getElementById("legal_document");
  var representative_name = document.getElementById("representative_name");
  var representative_id   = document.getElementById("representative_id");
  var date                = document.getElementById("date");
  var contact             = document.getElementById("contact");
  var email               = document.getElementById("email");
  var phone_number        = document.getElementById("phone_number");

  var result    = true

  if (business_name.value == "") {
    errorHandler(business_name, "business_name_error", "Campo obligatorio");
    result = false;
  }
  if (tradename.value == "") {
    errorHandler(tradename, "tradename_error", "Campo obligatorio");
    result = false;
  }
  if (legal_document.value == "") {
    errorHandler(legal_document, "legal_document_error", "Campo obligatorio");
    result = false;
  }
  if (representative_name.value == "") {
    errorHandler(representative_name, "representative_name_error", "Campo obligatorio");
    result = false;
  }
  if (representative_id.value == "") {
    errorHandler(representative_id, "representative_id_error", "Campo obligatorio");
    result = false;
  }
  if (date.value == "") {
    errorHandler(date, "date_error", "Campo obligatorio");
    result = false;
  }
  if (contact.value == "") {
    errorHandler(contact, "contact_error", "Campo obligatorio");
    result = false;
  }
  if (email.value == "") {
    errorHandler(email, "email_error", "Campo obligatorio");
    result = false;
  }
  if (phone_number.value == "") {
    errorHandler(phone_number, "phone_number_error", "Campo obligatorio");
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