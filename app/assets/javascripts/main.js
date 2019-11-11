var ready = function() {
  //*******Dashboard*******
  //Balance will display red if value is negative or green otherwise.
  var value = $(".balance").text();

  if (value.indexOf("-") >= 0) {
    $(".balance").addClass("red");
  } else {
    $(".balance").addClass("green");
  }

  //When "Add new" is clicked within the existing activity dropdown (which is the only option with a blank value),
  //spawn the add new activity name and category inputs. Otherwise, hide the activity name and category inputs.
  $("#entry_activity_id").change(function(){
    if($(this).val() == "") {
      $(".activity-name-input, .activity-category-input").removeClass("hidden");
    } else {
      $(".activity-name-input, .activity-category-input").addClass("hidden");
    }
  });  

  //*******Calendar events*******
  // When button is clicked, pull data from button and populate the form.
  $("[data-event-name]").click(function(e) {
    let eventName = $(this).data("eventName");
    let eventDuration = $(this).data("eventDuration");
    $("[data-event-name-input]").val(eventName);
    $("[data-event-minutes-input]").val(eventDuration);
  });

  // When button is clicked, clear the form.
  $("#clear_form").click(function(e) {
    $("#activity_name, #activity_category, #entry_minutes").val("");
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);

