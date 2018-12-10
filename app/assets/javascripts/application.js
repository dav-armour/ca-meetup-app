// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

var readURL = function(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.profile-pic').attr('src', e.target.result);
    }

    reader.readAsDataURL(input.files[0]);
  }
}

var ready = function() {
  $("#hamburger").on('click', function(){
    console.log("Clicked")
    $("#nav-list").toggleClass('open');
    $("#hamburger").toggleClass('open');
  });

  $("#nav-list a").on('click', function(event) {
    $("#nav-list").removeClass('open');
    $("#hamburger").removeClass('open');
  });

  // Used for profile image loading
  $(".file-upload").on('change', function(){
    readURL(this);
  });

  // Used for activating file input when label is clicked
  $(".upload-button, #plus-icon").on('click', function() {
      $(".file-upload").click();
  });

  $("#changePass").click(function(){
    $(".new-pass-input").attr("disabled",!this.checked);
  });

  $('.groups-style input[type="color"]').on('change', function() {
    var textColour = $('#group_text_colour').val();
    var backgroundColour = $('#group_background_colour').val();
    $('#group-style-preview').css("color", textColour);
    $('#group-style-preview').css("background-color", backgroundColour);
  });

  $("#group_short_name").on("input", function() {
    var input = $(this);
    var val = input.val();

    if (input.data("lastval") != val) {
      input.data("lastval", val);
      $('#group-style-preview').text(val);
    }
  });
};

// Make it work for page reloads and links

$(document).on('turbolinks:load', ready);