require 'integration_test_helper'

class BookmarksTest < ActionDispatch::IntegrationTest
  test "creating a new bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "Example.com"
    assert_bookmark_visible url: "http://example.com", title: "Example.com"
  end

  test "creating a new bookmark with some tags" do
    tag_names = ["tag-1", "tag-2"].join(TAG_SEPARATOR)
    given_a_user_bookmarks url: "http://example.com", title: "Example.com", tags: tag_names
    assert_bookmark_visible url: "http://example.com", title: "Example.com", tags: tag_names
  end

  test "editing a bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "original-title", tags: "original-tag", comments: "original-comments"
    and_a_user_edits_the_bookmark url: "http://example.com", title: "new-title", tags: "new-tag", comments: "new-comments"
    assert_bookmark_visible url: "http://example.com", title: "new-title", tags: "new-tag", comments: "new-comments"
  end

  test "viewing a single bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "original-title", tags: "original-tag", comments: "original-comments"
    get "/bookmarks/#{CGI.escape('http://example.com')}"
    assert_bookmark_visible url: "http://example.com", title: "original-title", tags: "original-tag", comments: "original-comments"
  end

  test "starting to type a tag will provide autocomplete suggestions" do
    # Provide data for the test
    tag_names = ["Existing tag", "something different"].join(TAG_SEPARATOR)
    create(:bookmark, url: 'http://existing.com', title: 'existing', tag_names: tag_names)

    # beginning of the use case
    url = "http://example.com"
    tag_names = ["tag-1", "tag-2"].join(TAG_SEPARATOR)
    given_a_user_bookmarks url: url, title: "Example.com", tags: tag_names
    click_link "Edit the bookmark for #{url}"

    # test general expectations
    assert page.has_css?(".select2-container"), "expected form to have a select2 (jQuery lib) container"
    assert page.has_css?(".select2-drop", visible: false), "expected tags drop-down to be invisible when not focused"

    # test auto-completion
    fill_in "Tags", with: "ta"
    assert page.has_css?(".select2-drop", visible: true), "expected tags drop-down to be visible when focused"
    assert page.has_css?(".select2-result", text: "Existing tag"), "expected tag auto-complete to include a tag that matches"
    assert page.has_no_css?(".select2-result", text: "something different"), "expected tag auto-complete to not include a tag that doesn't match"
    assert page.has_no_css?(".select2-result", text: "tag-1"), "expected tag auto-complete to not include a tag that's already set"
  end
end