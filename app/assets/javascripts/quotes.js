function validateQuoteStep1() {

  var institution  = document.getElementById("institution");
  var payment      = document.getElementById("payment");
  var daily_salary = document.getElementById("daily_salary");
  var vacations    = document.getElementById("vacations");
  var holidays     = document.getElementById("holidays");

  var result    = true

  if (institution.value == "") {
    errorHandler(institution, "institution_error", "Campo obligatorio");
    result = false;
  }
  if (payment.value == "") {
    errorHandler(payment, "payment_error", "Campo obligatorio");
    result = false;
  }
  if (daily_salary.value == "") {
    errorHandler(daily_salary, "daily_salary_error", "Campo obligatorio");
    result = false;
  }
  if (vacations.value == "") {
    errorHandler(vacations, "vacations_error", "Campo obligatorio");
    result = false;
  }
  if (holidays.value == "") {
    errorHandler(holidays, "holidays_error", "Campo obligatorio");
    result = false;
  }
  return result;
}

function filterQuote(){
  var quotes = JSON.parse(document.querySelector('#quote').dataset.quotes);
  var search = $('#quote').val().toUpperCase();
  var ids = [0];
  quotes.forEach(function(quote) {
    if (quote.institution.toUpperCase().includes(search) || quote.number == parseInt(search)) {
      ids.push(quote.id);
    }
  });
  $.ajax({
    type: "GET",
    url: "/admin/quotes/",
    data:
    {
      utf8: "✓",
      ids: ids
    }
  });
}

function getElementByXpath(path) {
  return document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
}

$( document ).on('turbolinks:load', function() {

  $('#payment').on('change', function(){

    var payments = JSON.parse(document.querySelector('#requirements').dataset.payments);
    var paymentId = $(this).val();

    $('select[id^="_shift_id"]')

    payments.forEach(function(payment) {
      if (payment.id == paymentId) {
        payment
      }
    });
  });
  onInput("institution");
  onInput("payment");
  onInput("daily_salary");
  onInput("vacations");
  onInput("holidays");
}); 