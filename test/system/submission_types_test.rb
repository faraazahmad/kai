require "application_system_test_case"

class SubmissionTypesTest < ApplicationSystemTestCase
  setup do
    @submission_type = submission_types(:one)
  end

  test "visiting the index" do
    visit submission_types_url
    assert_selector "h1", text: "Submission types"
  end

  test "should create submission type" do
    visit submission_types_url
    click_on "New submission type"

    fill_in "Name", with: @submission_type.name
    click_on "Create Submission type"

    assert_text "Submission type was successfully created"
    click_on "Back"
  end

  test "should update Submission type" do
    visit submission_type_url(@submission_type)
    click_on "Edit this submission type", match: :first

    fill_in "Name", with: @submission_type.name
    click_on "Update Submission type"

    assert_text "Submission type was successfully updated"
    click_on "Back"
  end

  test "should destroy Submission type" do
    visit submission_type_url(@submission_type)
    click_on "Destroy this submission type", match: :first

    assert_text "Submission type was successfully destroyed"
  end
end
