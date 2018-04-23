import "./enqueue_button.css";

$(document).on("turbolinks:load", function() {
  $(document).on("ajax:success", "#enqueue_button form", function(event) {
    var [data, status, xhr] = event.detail;
    $("#enqueue_button").html($(xhr.responseText).html());
  });
});
