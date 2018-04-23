import "./labels_list.css";
var fetchLabels = function(artistId) {
  $.ajax({
    url: "/artists/artist_labels/" + artistId,
    type: "GET",
    dataType: "html",
    success: function(result) {
      $("#labels-list").html(result);
    },
    error: function(error) {
      console.log(error);
    }
  });
};

$(document).on("turbolinks:load", function() {
  // In artists show page
  if ($(".artists.show").length > 0) {
    $("#labels-list").html("Loading...");
    var artistId = $("#id").data().paramsId;
    fetchLabels(artistId);
  }
});
