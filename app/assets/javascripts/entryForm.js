var ready = function() {
  $("#entry_activity_id").change(function(){
    if($(this).val() == "")
    {
      $(".activity-name-input, .activity-category-input").removeClass("hidden");
      $("#entry_activity_id").addClass("hidden");
    }
  });  
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);

