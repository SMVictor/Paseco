function updateWorkRoles() {
  var lines = JSON.parse(document.querySelector('#table').dataset.lines);
  var change_lines = new Array();

  for (var i = 0; i < lines.length; i++) {
  	var shift = $("#shift_"+lines[i].id+" option:selected" ).val();
  	var subStall = $("#substall_"+lines[i].id+" option:selected" ).val();

  	var change = new Object();

  	if (lines[i].shift_id != shift && shift != "") {
  	  change.id  = lines[i].id;
  	  change.shift_id  = shift;
  	}

  	if (lines[i].sub_stall != subStall && subStall != "") {
  	  change.id  = lines[i].id;
  	  change.sub_stall = subStall;
  	}

  	if (change != null) {
  	  change_lines.push(change);
  	}
  }
  $.ajax({
    type: "GET",
    url: document.URL+"/update",
    data:{ changes: change_lines }
  });
}

function stallsFilter(roleID){

    var stallID = $( "#stalls_select option:selected" ).val();

    $.ajax({
      type: "GET",
      url: "/admin/work_roles/lines/"+roleID+"/"+stallID,
      data:
      {
        utf8: "✓",
        stall_id: stallID,
        ajax: true
      }
    });
  }

$( document ).on('turbolinks:load', function() {

	var lines = JSON.parse(document.querySelector('#table').dataset.lines);

	for (var i = 0; i < lines.length; i++) {
	  $("#shift_"+lines[i].id).val(lines[i].shift_id);
	  $("#substall_"+lines[i].id).val(lines[i].sub_stall);
	}
});