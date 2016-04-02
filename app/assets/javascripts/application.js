// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require jquery-maskMoney
//= require_tree .

$.fn.datepicker.defaults.format = "dd/mm/yyyy";
$.fn.datepicker.defaults.autoclose = true;

$(document).on('page:load', function() {
  load_datepicker();

  $('.mask-money').each( function(){
    $(this).maskMoney();
  });
});

$(document).ready(function(){
  load_datepicker();

  $('.mask-money').each( function(){
    $(this).maskMoney();
  });
});

function load_datepicker() {
  $('.datepicker').each(function() {
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
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
