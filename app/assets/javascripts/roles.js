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

function getDayName(){

  var comments = $('.comment');
  var days = ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'];

  for (var i = 0; i < comments.length; i++) {
    var dateString = $('#'+(comments[i].id).replace("comment", "date")).val();
    
    var dayInput   = $('#'+(comments[i].id).replace("comment", "day"));
    var date = new Date(dateString);
    var dayName = days[date.getDay()];
    dayInput.val(dayName);
  }
}

function addLine(employeeID, stallID, roleID){

   var url = "/admin/roles/lines/"+roleID+"/"+stallID+"/"+employeeID; 

   var post_url = $("form").attr("action"); //get form action url
   var request_method = $("form").attr("method"); //get form GET/POST method
   var form_data = $("form").serialize() + '&ajax=' + true; //Encode form elements for submission
      
  $.ajax({
    url : post_url,
    type: request_method,
    data : form_data,
    complete: function(result){
      $.ajax({
        type: "GET",
        url: url,
        data:
        {
          utf8: "✓",
          ajax: true,
          create: true
        }
      });
    }
  });

}

function filterPayrole(){
  var payrole_lines = JSON.parse(document.querySelector('#payrole').dataset.lines);
  var search = $('#payrole').val().toUpperCase();
  var ids = [0];
  payrole_lines.forEach(function(line) {
    if (line.employee.name.toUpperCase().includes(search) || line.employee.bank.toUpperCase().includes(search)) {
      ids.push(line.id);
    }
  });
  $.ajax({
    type: "GET",
    url: payrole_lines[0].role_id+"/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}

function filterByBank(){
  var payrole_lines = JSON.parse(document.querySelector('#payrole').dataset.lines);
  var search = $( "#banks option:selected" ).text();
  var ids = [0];

  payrole_lines.forEach(function(line) {
    if ((line.employee.bank == search && parseInt(line.net_salary) > 0) || search == "Seleccione una entidad bancaria") {
      ids.push(line.id);
    }
  });

  $.ajax({
    type: "GET",
    url: payrole_lines[0].role_id+"/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}

function focusHours(modalId, fieldId){
  $('#'+modalId).on('shown.bs.modal', function () {
    $('#'+fieldId).focus();
  });
}

function saveModalData(roleID, stallID, employeeID){

  var url = "/admin/roles/lines/"+roleID+"/"+stallID+"/"+employeeID; 
  var post_url = $("form").attr("action"); //get form action url
  var request_method = $("form").attr("method"); //get form GET/POST method
  var form_data = $("form").serialize() + '&ajax=' + true; //Encode form elements for submission

  $.ajax({
    url : post_url,
    type: request_method,
    data : form_data,
    complete: function(result){
      $.ajax({
        type: "GET",
        url: url,
        data:
        {
          utf8: "✓",
          ajax: true
        }
      });
    }
  });
}