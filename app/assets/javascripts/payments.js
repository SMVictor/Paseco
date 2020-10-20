function validatePaymentForm() {

  var name = document.getElementById("name");
  var result    = true

  if (name.value == "") {
    errorHandler(name, "name_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

function filterByStatus(){
  var status = $( "#status option:selected" ).text();

  $.ajax({
    type: "GET",
    url: document.URL,
    data:
    {
      utf8: "✓",
      status: status
    }
  });
}