require "application_system_test_case"

class HighlightsTest < ApplicationSystemTestCase
  setup do
    @highlight = highlights(:one)
  end

  test "visiting the index" do
    visit highlights_url
    assert_selector "h1", text: "Highlights"
  end

  test "should create highlight" do
    visit highlights_url
    click_on "New highlight"

    fill_in "Submission", with: @highlight.submission_id
    fill_in "Text", with: @highlight.text
    click_on "Create Highlight"

    assert_text "Highlight was successfully created"
    click_on "Back"
  end

  test "should update Highlight" do
    visit highlight_url(@highlight)
    click_on "Edit this highlight", match: :first

    fill_in "Submission", with: @highlight.submission_id
    fill_in "Text", with: @highlight.text
    click_on "Update Highlight"

    assert_text "Highlight was successfully updated"
    click_on "Back"
  end

  test "should destroy Highlight" do
    visit highlight_url(@highlight)
    click_on "Destroy this highlight", match: :first

    assert_text "Highlight was successfully destroyed"
  end
end
