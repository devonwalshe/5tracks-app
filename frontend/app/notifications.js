showHideFlash = function() {
  flash = $(".flash");
  if (flash.children().length > 0) {
    flash
      .show()
      .delay(3000)
      .fadeToggle(500);
  }
};

$(document).ready(function() {
  showHideFlash();
});
