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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require bootstrap-datepicker
//= require jquery-maskMoney
//= require_tree .

$.fn.datepicker.defaults.format = "dd/mm/yyyy";
$.fn.datepicker.defaults.autoclose = true;

$(document).on('page:load', function() {
  load_datepicker();
  load_mask_money();
});

$(document).ready(function(){
  load_datepicker();
  load_mask_money();
});

function load_mask_money() {
  $('.mask-money').each( function(){
    $(this).maskMoney();
  });
}

function load_datepicker() {
  $('.datepicker').each(function() {
    $(this).datepicker({
      format: 'dd/mm/yyyy',
      autoclose: true
    });
  });
}
