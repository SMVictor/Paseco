function validateSignInForm() {
  var email = document.getElementById("email");
  var password = document.getElementById("password");
  var users = JSON.parse(document.querySelector('#email').dataset.users);
  var email_exist = false;
  var result = true;
  var emailFormat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  if (password.value == "") {
    errorHandler(password, "password_error", "Debe ingresar la contraseña");
    result = false;
  }

  for (var i = 0; i < users.length; i++) {
    if(users[i].email==email.value && users[i].invitation == "accepted"){
      email_exist = true;
    }
  }

  if (emailFormat.test(String(email.value).toLowerCase()) == false) {
    errorHandler(email, "email_error", "Debe ingresar un email válido");
    result = false;
  }
  else{
    if (!email_exist) {
      errorHandler(email, "email_error", "No puede iniciar sesión con " + email.value);
      result = false;
    }
  }

  return result;
}

function validateSignUpForm() {
  
  var name           = document.getElementById("name");
  var identification = document.getElementById("identification");
  var email          = document.getElementById("email");
  var password       = document.getElementById("password");
  var confirmation   = document.getElementById("confirmation");

  var users = JSON.parse(document.querySelector('#email').dataset.users);
  var email_exist = false;
  var result = true;
  var emailFormat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo Obligatorio");
    result = false;
  }

  if (identification.value == "") {
    errorHandler(identification, "identification_error", "Campo Obligatorio");
    result = false;
  }
  else{
    identification.value = identification.value.replace(/-/g,'');
  }

  if (password.value == "") {
    errorHandler(password, "password_error", "Campo Obligatorio");
    result = false;
  }

  if (confirmation.value != password.value) {
    errorHandler(confirmation, "confirmation_error", "Las contraseñas no coinciden");
    result = false;
  }

  for (var i = 0; i < users.length; i++) {
    if(users[i].email==email.value){
      email_exist = true;
    }
  }

  if (emailFormat.test(String(email.value).toLowerCase()) == false) {
    errorHandler(email, "email_error", "Debe ingresar un email válido");
    result = false;
  }
  else{
    if (email_exist) {
      errorHandler(email, "email_error", "El email ya se encuentra en uso por otra cuenta");
      result = false;
    }
  }
  return result;
}

$( document ).on('turbolinks:load', function() {

  permissions = ['Administrador', 'Gerente', 'Colaborador', 'Recursos Humanos']

  for (var i = 0; i < permissions.length; i++) {

    $('#permission').append('<option value="'+i+'">'+permissions[i]+'</option>');
  }
});