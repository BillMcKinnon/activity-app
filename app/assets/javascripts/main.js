var ready = function() {
  //*******Dashboard*******
  //Hide 30 day view on page load.
  $("#chart-2").addClass("hidden");

  //Show either 30 day or 7 day chart when corresponding button is clicked.
  $("#30_day_view").click(function(){
    $("#chart-1").addClass("hidden");
    $("#chart-2").removeClass("hidden");
  });  

  $("#7_day_view").click(function(){
    $("#chart-2").addClass("hidden");
    $("#chart-1").removeClass("hidden");
  });  

  //Balance will display red if value is negative or green otherwise.
  var value = $("[data-balance]").text();

  if (value.indexOf("-") >= 0) {
    $("[data-balance]").addClass("red");
  } else {
    $("[data-balance]").addClass("green");
  }

  //When "Add new" is clicked within the existing activity dropdown (which is the only option with a blank value),
  //spawn the add new activity name and category inputs. Otherwise, hide the activity name and category inputs.
  $("[data-activity-name-select]").change(function(){
    if($(this).val() == "") {
      $(".activity-name-input, .activity-category-input").removeClass("hidden");
    } else {
      $(".activity-name-input, .activity-category-input").addClass("hidden");
    }
  });  

  //*******Calendar Events*******
  // When button is clicked, pull data from button and populate the form.
  $("[data-event-name]").click(function(e) {
    let eventName = $(this).data("eventName");
    let eventDuration = $(this).data("eventDuration");
    $("[data-event-name-input]").val(eventName);
    $("[data-event-minutes-input]").val(eventDuration);
  });

  // When button is clicked, clear the form.
  $("[data-clear-form]").click(function(e) {
    $("#activity_name, #activity_category, #entry_minutes").val("");
  });
};

$(document).ready(ready);

