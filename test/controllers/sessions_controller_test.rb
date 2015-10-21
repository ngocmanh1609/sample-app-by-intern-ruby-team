# encoding: utf-8
require 'test_helper'
# Session controller test
class SessionsControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end
end
