$(function() {
  $('#bookmark_tag_names').select2({
    tags: APP.tags,
    separator: " ",
    tokenSeparators: [" "]
  });

  $('#roosmarklet').click(function() {
    alert("I'm a bookmarklet. Drag me to your bookmarks bar for easier bookmarking.");
    return false;
  });
});