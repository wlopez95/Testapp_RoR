require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    #review the route and check the status of the url
    get "/categories/new"
    assert_response :success

    #creates a new category and review the action redirect to
    assert_difference("Category.count",1) do
      post categories_path, params: { category: { name:"Travel" } }
      assert_response :redirect
    end

    #reviews if the redirect works fine to a valid route
    follow_redirect!
    assert_response :success

    #check if the name "Travel" exist in the body
    assert_match "Travel", response.body
  end


  test "get new category form reject invalid category" do
    get "/categories/new"
    assert_response :success

    assert_no_difference("Category.count") do
      post categories_path, params: { category: { name:"" } }
    end

    assert_match "The following errors prevent the Category being sabed", response.body
    assert_select 'div.alert'
  end
end
