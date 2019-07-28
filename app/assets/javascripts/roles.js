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
function changeIconColor(buttonID){
  var inputs = document.getElementsByClassName("hours");
  var buttons = document.getElementsByName("btn_modal");
  if (buttonID == null) {
    for (var i = 0; i < inputs.length; i++) {
      buttons[i].style.color = "#8068D9";
    }
  }
  else{
    document.getElementById(buttonID).style.color = "#5DC973"; 
  }
}

function getDayName(lineID){

  var holidayCheckBox = $("#holiday_"+lineID);
  var dateField       = $("#date_"+lineID);
  var holidays = JSON.parse(document.querySelector('#role_line_fields').dataset.holidays);

  holidayCheckBox.prop( "checked", false );

  for (var i = 0; i < holidays.length; i++) {
    if (holidays[i].date == dateField.val()) {
      holidayCheckBox.prop( "checked", true );
    }
  }

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
   var form_data = $("form").serialize() + '&ajax=' + true + '&create=' + true; //Encode form elements for submission
      
  $.ajax({
    url : post_url,
    type: request_method,
    data : form_data
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
    url: document.URL,
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
    if ((line.employee.bank == search && line.employee.account != "" && line.employee.account != null && parseInt(line.net_salary) > 0) || search == "Seleccione una entidad bancaria") {
      ids.push(line.id);
    }
    else if ((line.employee.account == "" || line.employee.account == null) && search == "SIN CUENTA")  {
      ids.push(line.id);
    }
  });

  $.ajax({
    type: "GET",
    url: document.URL,
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}

function focusField(modalId, fieldId){
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
    data : form_data
  });
}

function hoursValidation(lineID, roleID, stallID, employeeID){

    saveModalData(roleID, stallID, employeeID)

    var requirements    = JSON.parse(document.querySelector('#addPayment'+lineID).dataset.requirements);
    var lines           = JSON.parse(document.querySelector('#addPayment'+lineID).dataset.lines);
    var currentShift    = $('#shift_'+lineID).children("option:selected");
    var currentPosition = $('#position_'+lineID).children("option:selected");
    var currentHours    = $('#hours_'+lineID).val();
    var currentDate     = $('#date_'+lineID).val();
    var dateHours       = 0;
    var existRequerimet = false;

    for (var i = 0; i < lines.length; i++) {

      if ($('#date_'+lines[i].id).length) {
        lines[i].position_id = $('#position_'+lines[i].id).children("option:selected").val();
        lines[i].shift_id    = $('#shift_'+lines[i].id).children("option:selected").val();
        lines[i].hours       = $('#hours_'+lines[i].id).val();
        lines[i].date        = $('#date_'+lines[i].id).val();
      }

      if ( lines[i].date == currentDate && lines[i].id != lineID ) {

        if ( lines[i].shift_id == currentShift.val() && lines[i].position_id == currentPosition.val() ) {
          dateHours += parseFloat(lines[i].hours);
        }
      }
    }

    if (currentHours == "") {
      currentHours = 0
    }
    dateHours += parseFloat(currentHours);
    
    for (var i = 0; i < requirements.length; i++) {
      if (requirements[i].shift_id == currentShift.val() && requirements[i].position_id == currentPosition.val()) {
        var requiredHours  = parseFloat(requirements[i].hours) * parseFloat(requirements[i].workers);
        var availableHours = requiredHours - dateHours
        if ( availableHours < 0 ) {
          alert("Cuidado!!! Está excediendo el requerimiento diario de '"+currentPosition.text()+"' en el turno '"+currentShift.text()+"' en un total de horas de: "+(availableHours*-1).toFixed(2));
        }
        existRequerimet = true;
        break;
      }
    }
    if (!existRequerimet) {
      alert("No existe un requerimiento establecido para el cargo '"+currentPosition.text()+"' en el turno '"+currentShift.text()+"'");
    }
  }

  function stallsHoursFilter(){

    var stallID = $( "#stalls_select option:selected" ).val();

    $.ajax({
      type: "GET",
      url: document.URL,
      data:
      {
        utf8: "✓",
        ids: stallID,
        ajax: true
      }
    });
  }

  function registerEmployee(employeeID){

    var form_data = $("form").serialize() + '&id=' + employeeID; //Encode form elements for submission

    $.ajax({
      type: "PATCH",
      url: "/",
      data: form_data
    });
  }

