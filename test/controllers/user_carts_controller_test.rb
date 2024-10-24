require "test_helper"

class UserCartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_cart = user_carts(:one)
  end

  test "should get index" do
    get user_carts_url, as: :json
    assert_response :success
  end

  test "should create user_cart" do
    assert_difference("UserCart.count") do
      post user_carts_url, params: { user_cart: { cart_id: @user_cart.cart_id, user_id: @user_cart.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show user_cart" do
    get user_cart_url(@user_cart), as: :json
    assert_response :success
  end

  test "should update user_cart" do
    patch user_cart_url(@user_cart), params: { user_cart: { cart_id: @user_cart.cart_id, user_id: @user_cart.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy user_cart" do
    assert_difference("UserCart.count", -1) do
      delete user_cart_url(@user_cart), as: :json
    end

    assert_response :no_content
  end
end
