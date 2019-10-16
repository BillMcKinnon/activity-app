//Dashboard - Hide existing activity_name field and show add new activity_name and
//activity_category fields. This will be refactored.
var ready = function() {
  $("#entry_activity_id").change(function(){
    if($(this).val() == "")
    {
      $(".activity-name-input, .activity-category-input").removeClass("hidden");
      $("#entry_activity_id").addClass("hidden");
    }
  });  
};

//Dashboard - When button is clicked, show form for pulling calendar data.
var ready = function () {
  $("#add_event").click(function() {
    $(this).addClass("hidden");
    $(".pull-event-form").removeClass("hidden");
  });
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);

