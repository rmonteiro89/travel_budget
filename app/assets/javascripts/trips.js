// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('change', '#select_country', function (e) {
  var current_obj = $(this);
  var country_name = current_obj.val();
  set_cities(country_name);
  set_currency(country_name);
});

function set_cities(country_name) {
  var url = '/cities';
  $.ajax({
    type: 'get',
    url: url,
    data: {country_name: country_name},
    headers: {
      Accept: "application/json"
    },
    success : function(cities) {
      var noneOptionElement = new Option('Select a city', '')
        , optionElementSelected = noneOptionElement.value;
      $('#select_city').empty();
      $('#select_city').append(noneOptionElement);

      for (var i = 0; i < cities.length; i++) {
        var label = cities[i]
          , value = cities[i]
          , optionElement = new Option(label, value)
        ;

        $('#select_city').append(optionElement);
      }
    },
    error : function(res) {
      alert('Error: ' + res.status + ' ' + res.statusText);
    }
  });
}

function set_currency(country_name) {
  var url = '/currencies';
  var currencies = [];
  $.ajax({
    type: 'get',
    url: url,
    data: {country_name: country_name},
    headers: {
      Accept: "application/json"
    },
    success : function(currencies) {
      $('#select_currency').find("option[selected='selected']").removeAttr('selected');
      var value = currencies[0]['code'];
      $('#select_currency').find('option[value='+value+']').attr('selected', 'selected');
    },
    error : function(res) {
      alert('Error: ' + res.status + ' ' + res.statusText);
    }
  });
}

$(document).on('click', '#end_date', function () {
  start_date_before_end_date();
});

$(document).on('change', '#start_date', function () {
  var current_obj = $(this);
  start_date_before_end_date();
});

function start_date_before_end_date() {
  var start_date = $('#start_date').datepicker('getDate');
  var end_date = $('#end_date').datepicker('getDate');

  if (end_date && start_date.valueOf() > end_date.valueOf()) {
    $('#end_date').datepicker('setDate', start_date);
    $('#end_date').datepicker('update');
    $('#end_date')[0].focus();
  }

  $('#end_date').datepicker('setStartDate', start_date);
  $('#end_date').datepicker('update');
}
