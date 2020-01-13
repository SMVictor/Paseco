function validateStallForm() {

  var name      = document.getElementById("name");
  var substalls = document.getElementById("substalls");
  var viatical  = document.getElementById("viatical");

  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  if (substalls.value == 0) {
    errorHandler(substalls, "substalls_error", "Campo obligatorio");
    result = false;
  }
  if (viatical.value == "") {
    errorHandler(viatical, "viatical_error", "Campo obligatorio");
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
};
