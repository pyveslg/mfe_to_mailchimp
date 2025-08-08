require "test_helper"

class NewsletterControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get newsletter_show_url
    assert_response :success
  end
end
