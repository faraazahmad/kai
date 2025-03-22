require "test_helper"

class PdfsControllerTest < ActionDispatch::IntegrationTest
  test "should get open_pdf" do
    get pdfs_open_pdf_url
    assert_response :success
  end
end
