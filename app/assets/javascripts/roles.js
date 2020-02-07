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

function filterPayrole(){
  var payrole_lines = JSON.parse(document.querySelector('#payrole').dataset.lines);
  var search = $('#payrole').val().toUpperCase();
  var ids = [0];
  payrole_lines.forEach(function(line) {
    if (line.name.toUpperCase().includes(search) || line.bank.toUpperCase().includes(search)) {
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
    if ((line.bank == search && line.account != "" && line.account != null && parseInt(line.net_salary) > 0) || search == "Seleccione una entidad bancaria") {
      ids.push(line.id);
    }
    else if ((line.account == "" || line.account == null) && search == "SIN CUENTA")  {
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

function filterBonus(){
  var extra_payrole_lines = JSON.parse(document.querySelector('#extra_payrole').dataset.lines);
  var search = $('#extra_payrole').val().toUpperCase();
  var ids = [0];
  extra_payrole_lines.forEach(function(line) {
    if (line.name.toUpperCase().includes(search) || line.bank.toUpperCase().includes(search)) {
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

function filterBonusByBank(){
  var extra_payrole_lines = JSON.parse(document.querySelector('#extra_payrole').dataset.lines);
  var search = $( "#banks option:selected" ).text();
  var ids = [0];

  extra_payrole_lines.forEach(function(line) {
    if ((line.bank == search && line.account != "" && line.account != null && parseInt(line.total) > 0) || search == "Seleccione una entidad bancaria") {
      ids.push(line.id);
    }
    else if ((line.account == "" || line.account == null) && search == "SIN CUENTA")  {
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

function changeIconColor(){

  var inputs = document.getElementsByClassName("hours");
  var buttons = document.getElementsByName("btn_modal");

  for (var i = 0; i < inputs.length; i++) {

    if (inputs[i].value != "") {
      buttons[i].style.color = "#5DC973";
    }
  }
}

function getDayName(element){

  var comments = $('.comment');
  var days = ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'];

  if (element != 1) {

    var dateField       = $(element);
    var lineCode        = dateField.attr('name').split(']')[1].replace('[', '');
    var holidayCheckBox = $("#role_role_lines_attributes_"+lineCode+"_holiday");
    var holidays = JSON.parse(document.querySelector('#role_line_fields').dataset.holidays);

    holidayCheckBox.prop( "checked", false );

    for (var i = 0; i < holidays.length; i++) {
      if (holidays[i].date == dateField.val()) {
        holidayCheckBox.prop( "checked", true );
      }
    }

    var dayInput   = $("#role_role_lines_attributes_"+lineCode+"_day");
    var date = new Date(dateField.val());
    var dayName = days[date.getDay()];
    dayInput.val(dayName);

  }
  else{
    for (var i = 0; i < comments.length; i++) {
      var code = comments[i].name.split(']')[1].replace('[', '');
      var dayInput   = $("#role_role_lines_attributes_"+code+"_day");
      var date = new Date($("#role_role_lines_attributes_"+code+"_date").val());
      var dayName = days[date.getDay()];
      dayInput.val(dayName);
    }
  }
}

function showModal(element){
  var modal = $($(element).parent().parent().children()[8]);
  modal.modal('toggle');
}

function loadEmployee(roleID, stallID){

  var valueSelected = $("#employee_select option:selected").val();

  $.ajax({
    type: "GET",
    url: "/admin/roles/lines/"+roleID+"/"+stallID+"/"+valueSelected,
    data:
    {
      utf8: "✓",
      ajax: true
    }
  });
}

function hoursValidation(element){

  var lineCode        = $(element).attr('name').split(']')[1].replace('[', '');

  var requirements    = JSON.parse(document.querySelector('#role_lines').dataset.requirements);
  var total_lines     = JSON.parse(document.querySelector('#role_lines').dataset.date_lines);
  var positions       = JSON.parse(document.querySelector('#role_lines').dataset.positions);

  var lines           = $('[id=role_line_fields]');
  var currentShift    = $('#role_role_lines_attributes_'+lineCode+'_shift_id').children("option:selected");
  var currentPosition = $('#role_role_lines_attributes_'+lineCode+'_position_id').children("option:selected");
  var currentHours    = $('#role_role_lines_attributes_'+lineCode+'_hours').val();
  var currentDate     = $('#role_role_lines_attributes_'+lineCode+'_date').val();
  var dateHours       = 0;
  var existRequerimet = false;
  var currentEmployee = $("#employee_select option:selected").val();
  var currentArea     = 0;

  for (var i = 0; i < positions.length; i++) {
    if( positions[i].id == currentPosition.val()) {
      currentArea = positions[i].area_id;
      break;
    }
  }

  for (var i = 0; i < lines.length; i++) {

    var line_fields = $(lines[i]).children().children();

    var date     = $($($(line_fields[3]).children()[0]).children()[0]).children()[1];
    var shift    = $($($(line_fields[3]).children()[0]).children()[1]).children()[1];
    var position = $($($(line_fields[3]).children()[0]).children()[3]).children()[1];
    var hours    = $(line_fields[4]).children()[1];
    var code     = $(date).attr('name').split(']')[1].replace('[', '');
    var area     = 0;

    for (var j = 0; j < positions.length; j++) {
      if( positions[j].id == position.value ) {
        area = positions[j].area_id;
        break;
      }
    }

    if ( date.value == currentDate && code != lineCode ) {
      if ( shift.value == currentShift.val() ) {
        if (position.value == currentPosition.val() || (area==1 && currentArea == 1)) {
          dateHours += parseFloat(hours.value);
        }
      }
    }
  }

  for (var i = 0; i < total_lines.length; i++) {

    var date     = total_lines[i].date;
    var shift    = total_lines[i].shift_id;
    var position = total_lines[i].position_id;
    var hours    = total_lines[i].hours;
    var employee = total_lines[i].employee_id;
    var area     = 0;

    for (var j = 0; j < positions.length; j++) {
      if( positions[j].id == position ) {
        area = positions[j].area_id;
        break;
      }
    }

    if ( date == currentDate && employee != currentEmployee ) {
      if ( shift == currentShift.val() ) {
        if ( position == currentPosition.val() || (area==1 && currentArea == 1) ) {
          if (hours == "") {
            hours = 0;
          }
          dateHours += parseFloat(hours);
        }
      }
    }
  }

  if (currentHours == "") {
    currentHours = 0;
  }

  dateHours += parseFloat(currentHours);
    
  for (var i = 0; i < requirements.length; i++) {

    var area = 0;

    for (var j = 0; j < positions.length; j++) {
      if( positions[j].id == requirements[i].position_id ) {
        area = positions[j].area_id;
        break;
      }
    }

    if (requirements[i].shift_id == currentShift.val() && (requirements[i].position_id == currentPosition.val() || (area == 1 && currentArea == 1))){

      var requiredHours  = parseFloat(requirements[i].hours) * parseFloat(requirements[i].workers);
      var availableHours = requiredHours - dateHours;
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