require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @post = posts(:one)
  # end

  # test "should get index" do
  #   get posts_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_post_url
  #   assert_response :success
  # end

  # test "should create post" do
  #   assert_difference('Post.count') do
  #     post posts_url, params: { post: { content: @post.content, title: @post.title } }
  #   end

  #   assert_redirected_to post_url(Post.last)
  # end

  # test "should show post" do
  #   get post_url(@post)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_post_url(@post)
  #   assert_response :success
  # end

  # test "should update post" do
  #   patch post_url(@post), params: { post: { content: @post.content, title: @post.title } }
  #   assert_redirected_to post_url(@post)
  # end

  # test "should destroy post" do
  #   assert_difference('Post.count', -1) do
  #     delete post_url(@post)
  #   end

  #   assert_redirected_to posts_url
  # end
  #
  def setup
    @post = create(:post)
  end

  def test_index
    get "/posts"
    assert_response :success
    assert_includes response.body, @post.id.to_s
    assert_includes response.body, @post.title
  end

  def test_show
    get "/posts/#{@post.id}"
    assert_response :success
    assert_includes response.body, @post.id.to_s
    assert_includes response.body, @post.title
  end

  def test_creart_ok
    # post "/posts"
    # assert_response :success
    assert_difference('Post.count') do
      post "/posts", params: { post: { content: @post.content, title: @post.title } }
    end
  end

  def test_creart_content
    post "/posts", params: { post: { content: @post.content, title: @post.title } }
    @post_1 = Post.last
    assert_equal @post.title, @post_1.title
    assert_equal @post.content, @post_1.content
  end

  def test_update
    patch "/posts/#{@post.id}", params: { post: { content: "birdddd", title: "cooll" } }
    assert_equal "birdddd", @post.reload.content
    assert_equal "cooll", @post.reload.title
  end

  def test_destroy
    assert_difference('Post.count', -1) do
      delete "/posts/#{@post.id}"
    end
    assert_nil Post.find_by(id: @post.id)
    assert_raises { Post.find(@post.id) }
    assert_raises(ActiveRecord::RecordNotFound) { Post.find(@post.id) }
  end
end
