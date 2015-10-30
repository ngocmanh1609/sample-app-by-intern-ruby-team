# encoding: utf-8
require 'test_helper'
# comment test
class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    @comment = Comment.new(content: 'Lorem', user_id: @user.id, micropost_id: @micropost.id)
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'user id should be present' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'micropost id should be present' do
    @comment.micropost_id = nil
    assert_not @comment.valid?
  end

  test 'content should be present' do
    @comment.content = '   '
    assert_not @comment.valid?
  end

  test 'content should be at most 200 characters' do
    @comment.content = 'a' * 201
    assert_not @comment.valid?
  end

  test 'order should be most recent first' do
    assert_equal comments(:most_recent), Comment.first
  end
end
