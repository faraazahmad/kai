require "test_helper"

class SubmissionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @submission_type = submission_types(:one)
  end

  test "should get index" do
    get submission_types_url
    assert_response :success
  end

  test "should get new" do
    get new_submission_type_url
    assert_response :success
  end

  test "should create submission_type" do
    assert_difference("SubmissionType.count") do
      post submission_types_url, params: { submission_type: { name: @submission_type.name } }
    end

    assert_redirected_to submission_type_url(SubmissionType.last)
  end

  test "should show submission_type" do
    get submission_type_url(@submission_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_submission_type_url(@submission_type)
    assert_response :success
  end

  test "should update submission_type" do
    patch submission_type_url(@submission_type), params: { submission_type: { name: @submission_type.name } }
    assert_redirected_to submission_type_url(@submission_type)
  end

  test "should destroy submission_type" do
    assert_difference("SubmissionType.count", -1) do
      delete submission_type_url(@submission_type)
    end

    assert_redirected_to submission_types_url
  end
end
