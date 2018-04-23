var replaceUrlParams = function(url, paramName, paramValue) {
  if (paramValue == null) {
    paramValue = "";
  }
  var pattern = new RegExp("\\b(" + paramName + "=).*?(&|$)");
  if (url.search(pattern) >= 0) {
    return url.replace(pattern, "$1" + paramValue + "$2");
  }
  url = url.replace(/\?$/, "");
  return (
    url + (url.indexOf("?") > 0 ? "&" : "?") + paramName + "=" + paramValue
  );
};

var paginationStateListener = function() {
  // $("nav.pagination a").off('click');
  $(document).on("click", ".pagination a[data-remote=true]", function(e) {
    var paramName = $(this)
      .closest(".paginated")
      .attr("param");
    var linkUrl = new URL(this.href);
    var paramVal = linkUrl.searchParams.get(paramName);
    var url = replaceUrlParams(location.href, paramName, paramVal);
    history.pushState(url, window.title, url);
  });
};

$(document).on("turbolinks:load", function() {
  paginationStateListener();
});
