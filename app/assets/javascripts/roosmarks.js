$(function() {
  $('#bookmark_tag_names').select2({
    tags: APP.tags,
    separator: APP.tag_separator,
    tokenSeparators: [APP.tag_separator]
  });

  $('#roosmarklet').click(function() {
    alert("I'm a bookmarklet. Drag me to your bookmarks bar for easier bookmarking.");
    return false;
  });
});